package com.shirokumacafe.archetype.service;

import com.shirokumacafe.archetype.common.utils.MessageUtil;
import com.shirokumacafe.archetype.common.utils.PropertiesUtil;
import com.shirokumacafe.archetype.model.resp.RespTextMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.Map;

/**
 * 请求消息处理 事件
 *
 * @author wrp
 * @Description
 * @since 2017/12/5
 */
@Service
public class EventMessageHandleService {

    private static final Logger LOG = LoggerFactory.getLogger(EventMessageHandleService.class);

    @Autowired
    private HttpServletRequest request;

    public String handle(Map<String, String> reqMsg) {

        // 事件类型
        String eventType = reqMsg.get("Event");
        // 订阅
        if (eventType.equals(MessageUtil.EVENT_TYPE_SUBSCRIBE)) {

            RespTextMessage respTextMessage = new RespTextMessage();
            respTextMessage.setFromUserName(reqMsg.get("ToUserName"));
            respTextMessage.setToUserName(reqMsg.get("FromUserName"));
            respTextMessage.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_TEXT);
            respTextMessage.setFuncFlag(0);
            String content = "";
            try {
                String wwwRoot = PropertiesUtil.getProperties().getProperty("www.root");
                String bindingPageUrl = wwwRoot + request.getContextPath() + "/front/toBinding?weixinId=" + reqMsg.get("FromUserName");
                LOG.info("===bindingPageUrl===" + bindingPageUrl);
                content = "<a href=\"" + bindingPageUrl + "\">谢谢您关注课程公众号，点击这条消息进行绑定，或发送【菜单】查看更多信息</a>";
            } catch (IOException e) {
                LOG.error("读取文件异常。", e);
                content = "服务异常，请稍后重试！";
            }
            respTextMessage.setContent(content);
            return MessageUtil.textMessageToXml(respTextMessage);

        }
        // 取消订阅
        else if (eventType.equals(MessageUtil.EVENT_TYPE_UNSUBSCRIBE)) {
            // TODO 取消订阅后用户再收不到公众号发送的消息，因此不需要回复消息
        }
        // 自定义菜单点击事件
        else if (eventType.equals(MessageUtil.EVENT_TYPE_CLICK)) {
            // TODO 自定义菜单权没有开放，暂不处理该类消息
        }
        return null;
    }
}
