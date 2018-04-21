package com.shirokumacafe.archetype.service;

import com.alibaba.fastjson.JSON;
import com.shirokumacafe.archetype.common.utils.MessageUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * 微信主业务
 *
 * @author wrp
 * @since 2017/11/29
 */
@Service
public class CoreService {

    private static final Logger LOG = LoggerFactory.getLogger(CoreService.class);

    @Autowired
    private EventMessageHandleService eventMessageHandleService;

    @Autowired
    private TextMessageHandleService textMessageHandleService;

    public String processRequest(HttpServletRequest request) {
        String respMsg = null;
        try {
            // xml请求解析
            Map<String, String> reqMsgMap = MessageUtil.xmlToMap(request);
            LOG.info("CoreServiceImpl.processRequest===reqMsgMap:" + JSON.toJSONString(reqMsgMap));
            // 消息类型
            String msgType = reqMsgMap.get("MsgType");
            switch (msgType) {
                case MessageUtil.REQ_MESSAGE_TYPE_TEXT:
                    return textMessageHandleService.handle(reqMsgMap);
                case MessageUtil.REQ_MESSAGE_TYPE_EVENT:
                    return eventMessageHandleService.handle(reqMsgMap);
                default:
                    return textMessageHandleService.handle(reqMsgMap);
            }
        } catch (Exception e) {
            LOG.error("服务异常", e);
        }
        return respMsg;
    }

}
