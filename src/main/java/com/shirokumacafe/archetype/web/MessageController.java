package com.shirokumacafe.archetype.web;

import com.shirokumacafe.archetype.common.mybatis.Page;
import com.shirokumacafe.archetype.common.utilities.Responses;
import com.shirokumacafe.archetype.entity.Message;
import com.shirokumacafe.archetype.entity.MessageExt;
import com.shirokumacafe.archetype.entity.QuestionMessage;
import com.shirokumacafe.archetype.entity.Work;
import com.shirokumacafe.archetype.service.MessageService;
import com.shirokumacafe.archetype.service.WorkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

/**
 * @since 2018/4/8
 */
@Controller
@RequestMapping(value = "/message")
public class MessageController {

    @Autowired
    private MessageService messageService;
    @Autowired
    private WorkService workService;

    /***********************答疑 begin************************************/

    @RequestMapping("toQuestionMessage")
    public String toQuestionMessage(Integer wId, Model model) {
        model.addAttribute("wId", wId);
        return "questionMessage";
    }

    @RequestMapping(value = "questionMessageList", method = RequestMethod.GET)
    @ResponseBody
    public String questionMessageList(QuestionMessage questionMessage, Page page) {
        Page<QuestionMessage> questionMessagePage = messageService.questionMessagePage(questionMessage, page);
        return Responses.writeJson(questionMessagePage);
    }

    @RequestMapping(value = "replyQuestion", method = RequestMethod.POST)
    @ResponseBody
    public Map replyQuestion(Message message) {
        message.setMsgType(MessageService.MSG_TYPE_QUESTION);
        message.setOperRole(MessageService.OPER_ROLE_TEACHER);
        messageService.addMessage(message);
        return Responses.writeSuccess();
    }

/***********************答疑 end************************************/

/***********************参与讨论 begin************************************/

    @RequestMapping("toDiscuss")
    public String toDiscuss(Integer wId, Model model) {
        Work work = workService.getWork(wId);
        model.addAttribute("work", work);
        return "discuss";
    }

    @RequestMapping("getDiscuss")
    @ResponseBody
    public String getDiscuss(Integer wId) {
        MessageExt messageExt = new MessageExt();
        messageExt.setwId(wId);
        List<MessageExt> discussMessages = messageService.findDiscussMessage(messageExt);
        return Responses.writeJson(discussMessages);
    }

    @RequestMapping(value = "replyDiscuss", method = RequestMethod.POST)
    @ResponseBody
    public String replyDiscuss(Message message) {
        message.setMsgType(MessageService.MSG_TYPE_DISCUSS);
        return Responses.writeJson(messageService.addMessage(message));
    }

/***********************参与讨论 end************************************/

}
