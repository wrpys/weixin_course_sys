package com.shirokumacafe.archetype.service;

import com.github.pagehelper.PageHelper;
import com.shirokumacafe.archetype.common.Users;
import com.shirokumacafe.archetype.common.mybatis.Page;
import com.shirokumacafe.archetype.entity.Message;
import com.shirokumacafe.archetype.entity.MessageExt;
import com.shirokumacafe.archetype.entity.QuestionMessage;
import com.shirokumacafe.archetype.entity.Student;
import com.shirokumacafe.archetype.entity.User;
import com.shirokumacafe.archetype.repository.MessageMapper;
import com.shirokumacafe.archetype.repository.StudentMapper;
import com.shirokumacafe.archetype.repository.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.util.Date;
import java.util.List;

/**
 * @since 2018/4/8
 */
@Service
@Transactional
public class MessageService {

    public static final Integer DEFAULT_PARENT_ID = 0;

    // 消息类型
    public static final Integer MSG_TYPE_QUESTION = 1;
    public static final Integer MSG_TYPE_DISCUSS = 2;

    // 消息发送者的角色
    public static final Integer OPER_ROLE_TEACHER = 2;
    public static final Integer OPER_ROLE_STUDENT = 1;

    @Autowired
    private MessageMapper messageMapper;
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private StudentMapper studentMapper;
    @Autowired
    private Users sessionUsers;

    public MessageExt addMessage(Message message) {
        String operRoleName = "";
        String operName = "";
        if (OPER_ROLE_TEACHER.intValue() == message.getOperRole().intValue()) {
            message.setOperId(sessionUsers.getCurrentUser().getUserId());
            operRoleName = "老师";
            operName = sessionUsers.getCurrentUser().getNickName();
        } else if (OPER_ROLE_STUDENT.intValue() == message.getOperRole().intValue()) {
            message.setOperId(sessionUsers.getStudent().getsId());
            operRoleName = "学生";
            operName = sessionUsers.getStudent().getsName();
        }
        message.setCreateTime(new Date());
        messageMapper.insertSelective(message);
        MessageExt messageExt = new MessageExt();
        messageExt.setMsgId(message.getMsgId());
        messageExt.setMsgPid(message.getMsgPid());
        messageExt.setMsgType(message.getMsgType());
        messageExt.setOperRole(message.getOperRole());
        messageExt.setOperId(message.getOperId());
        messageExt.setwId(message.getwId());
        messageExt.setMsgContent(message.getMsgContent());
        messageExt.setCreateTime(message.getCreateTime());
        messageExt.setOperRoleName(operRoleName);
        messageExt.setOperName(operName);
        return messageExt;
    }

    public Page<QuestionMessage> questionMessagePage(QuestionMessage questionMessage, Page page) {
        questionMessage.setTeacherId(sessionUsers.getCurrentUser().getUserId());
        com.github.pagehelper.Page pageHelper = PageHelper.startPage(page.getPageIndex(), page.getLimit());
        List<QuestionMessage> list = messageMapper.selectQuestionMessageByParams(questionMessage);
        page.setRows(list);
        page.setResults(Integer.valueOf(String.valueOf(pageHelper.getTotal())));
        return page;
    }

    /**
     * 学生端 提问
     *
     * @param questionMessage
     * @return
     */
    public List<QuestionMessage> questionMessageList(QuestionMessage questionMessage) {
        questionMessage.setStudentId(sessionUsers.getStudent().getsId());
        return messageMapper.selectQuestionMessageByParams(questionMessage);
    }

    /**
     * 构造讨论列表
     *
     * @param messageExt
     * @return
     */
    public List<MessageExt> findDiscussMessage(MessageExt messageExt) {
        messageExt.setMsgType(MSG_TYPE_DISCUSS);
        messageExt.setMsgPid(DEFAULT_PARENT_ID);
        List<MessageExt> discussMessageList = messageMapper.selectMessageStudentExtByParams(messageExt);
        if (!CollectionUtils.isEmpty(discussMessageList)) {
            for (int i = 0, len = discussMessageList.size(); i < len; i++) {
                this.buildDiscussMessage(discussMessageList.get(i));
            }
        }
        return discussMessageList;
    }

    private void buildDiscussMessage(MessageExt messageExt) {
        MessageExt params = new MessageExt();
        params.setwId(messageExt.getwId());
        params.setMsgType(MSG_TYPE_DISCUSS);
        params.setMsgPid(messageExt.getMsgId());
        MessageExt m = messageMapper.selectMessageExtByParams(params);
        if (m == null) {
            return;
        }
        if (OPER_ROLE_TEACHER.intValue() == m.getOperRole().intValue()) {
            m.setOperRoleName("老师");
            User user = userMapper.selectByPrimaryKey(m.getOperId());
            m.setOperName(user.getNickName());
        } else if (OPER_ROLE_STUDENT.intValue() == m.getOperRole().intValue()) {
            m.setOperRoleName("学生");
            Student student = studentMapper.selectByPrimaryKey(m.getOperId());
            m.setOperName(student.getsName());
        }
        messageExt.setMessageExt(m);
        this.buildDiscussMessage(m);
    }

}
