package com.shirokumacafe.archetype.web.api;

import com.shirokumacafe.archetype.entity.Message;
import com.shirokumacafe.archetype.service.MessageService;
import com.shirokumacafe.archetype.service.StudentService;
import com.shirokumacafe.archetype.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.Map;

/**
 * 前台入口
 */
@Controller
@RequestMapping(value = "/front")
public class FrontAction {

    @Autowired
    private StudentService studentService;
    @Autowired
    private UserService userService;
    @Autowired
    private MessageService messageService;

    /**
     * 跳转到绑定页面
     */
    @RequestMapping(value = "toBinding", method = RequestMethod.GET)
    public String toBinding(String weixinId, Model model) {
        model.addAttribute("weixinId", weixinId);
        return "front/binding";
    }

    /**
     * 绑定
     *
     * @param weixinId 微信ID
     * @param operRole 角色：1.学生，2.教师
     * @param account  账号
     * @param model
     * @return
     */
    @RequestMapping(value = "binding", method = RequestMethod.POST)
    public String binding(String weixinId, Integer operRole, String account, Model model) {
        Map result = null;
        if (operRole.intValue() == 1) {
            result = studentService.binding(weixinId, account);
        } else if (operRole.intValue() == 2) {
            result = userService.binding(weixinId, account);
        }
        boolean isSucess = Boolean.valueOf(String.valueOf(result.get("success")));
        if (isSucess) {
            model.addAttribute("msg", "绑定成功");
            return "front/success";
        } else {
            model.addAttribute("weixinId", weixinId);
            model.addAttribute("msg", result.get("msg"));
            return "front/binding";
        }
    }

//    /**
//     * 作业列表
//     *
//     * @return
//     */
//    @RequestMapping(value = "toWorkList", method = RequestMethod.GET)
//    public String toWorkList(Page<WorkExt> page, Model model) {
//        if (page.getPageIndex() == 0) {
//            page.setPageIndex(0);
//        }
//        Page<WorkExt> resultPage = workService.listExtAll(page);
//        resultPage.setTotalPage(resultPage.getResults());
//        boolean isPre = true;
//        boolean isNext = true;
//        if (resultPage.getPageIndex() == 1) {
//            isPre = false;
//        }
//        if (resultPage.getPageIndex() >= resultPage.getTotalPage()) {
//            isNext = false;
//        }
//        model.addAttribute("isPre", isPre);
//        model.addAttribute("isNext", isNext);
//        model.addAttribute("page", resultPage);
//        return "front/work_list";
//    }

    /**
     * 作业详情
     *
     * @return
     */
//    @RequestMapping(value = "toWorkDetial", method = RequestMethod.GET)
//    public String toWorkDetial(Integer wId, Model model) {
//        workService.getWorkExt(wId, model);
//        return "front/work_detial";
//    }

    /**
     * 参与讨论
     *
     * @return
     */
//    @RequestMapping(value = "toMessage", method = RequestMethod.GET)
//    public String toMessage(Integer wId, Model model) {
//        workService.getWorkExt(wId, model);
//        MessageExt messageExt = new MessageExt();
//        messageExt.setwId(wId);
//        List<MessageExt> messageExts = messageService.findDiscussMessage(messageExt);
//        if (messageExts == null || messageExts.isEmpty()) {
//            model.addAttribute("isDis", false);
//        } else {
//            model.addAttribute("isDis", true);
//            for (int i = 0; i < messageExts.size(); i++) {
//                List<MessageExt> ms = new ArrayList<>();
//                getMessage(messageExts.get(i), ms);
//                if (!ms.isEmpty()) {
//                    messageExts.get(i).setMessageExts(ms);
//                }
//            }
//            model.addAttribute("messageExts", messageExts);
//        }
//        return "front/message";
//    }

//    private void getMessage(MessageExt messageExt, List<MessageExt> ms) {
//        if (messageExt.getMessageExt() != null) {
//            ms.add(messageExt.getMessageExt());
//            getMessage(messageExt.getMessageExt(), ms);
//        } else {
//            return;
//        }
//    }

    /**
     * 讨论页面
     *
     * @return
     */
    @RequestMapping(value = "toDiscussQuestionPage", method = RequestMethod.GET)
    public String toDiscussQuestionPage(Integer wId, Model model) {
        model.addAttribute("wId", wId);
        return "front/discuss_question";
    }

    /**
     * 答复页面
     *
     * @return
     */
    @RequestMapping(value = "toReplyPage", method = RequestMethod.GET)
    public String toReplyPage(Integer wId, Integer msgId, String msgContent, Model model) {
        model.addAttribute("wId", wId);
        model.addAttribute("msgId", msgId);
        model.addAttribute("msgContent", msgContent);
        return "front/message_reply";
    }

    /**
     * 提交回复
     *
     * @return
     */
    @RequestMapping(value = "submitReply", method = RequestMethod.POST)
    public String submitReply(Message message, Model model) {
        message.setMsgType(MessageService.MSG_TYPE_DISCUSS);
        message.setOperRole(MessageService.OPER_ROLE_STUDENT);
        messageService.addMessage(message);
        return "redirect:toMessage?wId=" + message.getwId();
    }

}