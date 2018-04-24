package com.shirokumacafe.archetype.service;

import com.alibaba.fastjson.JSON;
import com.shirokumacafe.archetype.entity.Message;
import com.shirokumacafe.archetype.entity.MessageExt;
import com.shirokumacafe.archetype.model.WeixinUserInfo;
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

    // 消息发送者的角色
    public static final Integer OPER_ROLE_STUDENT = 1;
    public static final Integer OPER_ROLE_TEACHER = 2;

    @Autowired
    private MessageMapper messageMapper;
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private StudentMapper studentMapper;
    @Autowired
    private FrontService frontService;

    public MessageExt addMessage(Message message, String weixinId) {
        WeixinUserInfo weixinUserInfo = frontService.getWeixinUserInfo(weixinId);
        message.setOperId(weixinUserInfo.getUserId());
        String operRoleName = "";
        if (OPER_ROLE_TEACHER.intValue() == weixinUserInfo.getRole().intValue()) {
            message.setOperRole(OPER_ROLE_TEACHER.intValue());
            operRoleName = "老师";
        } else if (OPER_ROLE_STUDENT.intValue() == weixinUserInfo.getRole().intValue()) {
            message.setOperRole(OPER_ROLE_STUDENT.intValue());
            operRoleName = "学生";
        }
        message.setCreateTime(new Date());
        messageMapper.insertSelective(message);
        MessageExt messageExt = new MessageExt();
        messageExt.setMsgId(message.getMsgId());
        messageExt.setMsgPid(message.getMsgPid());
        messageExt.setOperRole(message.getOperRole());
        messageExt.setOperId(message.getOperId());
        messageExt.setcId(message.getcId());
        messageExt.setMsgContent(message.getMsgContent());
        messageExt.setCreateTime(message.getCreateTime());
        messageExt.setOperRoleName(operRoleName);
        messageExt.setOperName(weixinUserInfo.getUserName());
        return messageExt;
    }

    /**
     * 构造讨论列表
     *
     * @param cId
     * @return
     */
    public List<MessageExt> findDiscussMessage(Integer cId) {
        MessageExt messageExt = new MessageExt();
        messageExt.setcId(cId);
        messageExt.setMsgPid(DEFAULT_PARENT_ID);
        List<MessageExt> discussMessageList = messageMapper.selectMessageExtByParams(messageExt);
        if (!CollectionUtils.isEmpty(discussMessageList)) {
            for (int i = 0, len = discussMessageList.size(); i < len; i++) {
                this.buildDiscussMessage(discussMessageList.get(i));
            }
        }
        System.out.println("===discussMessageList===" + JSON.toJSONString(discussMessageList));
        return discussMessageList;
    }

    private void buildDiscussMessage(MessageExt messageExt) {
        MessageExt params = new MessageExt();
        params.setcId(messageExt.getcId());
        params.setMsgPid(messageExt.getMsgId());
        List<MessageExt> mes = messageMapper.selectMessageExtByParams(params);
        if (mes == null || mes.isEmpty()) {
            return;
        }
        messageExt.setMessageExts(mes);
        for (int i = 0, len = mes.size(); i < len; i++) {
            this.buildDiscussMessage(mes.get(i));
        }
    }

}
