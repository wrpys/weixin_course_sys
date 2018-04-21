package com.shirokumacafe.archetype.web.api;

import com.shirokumacafe.archetype.common.utils.CheckUtil;
import com.shirokumacafe.archetype.service.CoreService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;

/**
 * 微信主入口接口
 *
 * @author wrp
 * @since 2017/11/29
 */
@RestController
@RequestMapping("weixin")
public class WeixinController {

    private static final Logger LOG = LoggerFactory.getLogger(WeixinController.class);

    @Autowired
    private CoreService coreService;

    private String token = "wrpys_weixin";

    /**
     * 确认请求来自微信服务器
     *
     * @param request
     * @param response
     */
    @RequestMapping(method = RequestMethod.GET)
    public void get(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String signature = request.getParameter("signature");
        String timestamp = request.getParameter("timestamp");
        String nonce = request.getParameter("nonce");
        String echostr = request.getParameter("echostr");
        LOG.info("weixin.get===signature:" + signature + ",timestamp:" + timestamp + ",nonce:" + nonce + ",echostr:" + echostr);
        PrintWriter out = response.getWriter();
        if (CheckUtil.checkSignature(signature, timestamp, nonce, token)) {
            out.print(echostr);
        }
        if (out != null) {
            out.close();
        }
    }

    /**
     * 处理微信服务器发来的消息
     *
     * @param request
     * @param response
     * @throws UnsupportedEncodingException
     */
    @RequestMapping(method = RequestMethod.POST)
    public void post(HttpServletRequest request, HttpServletResponse response) throws IOException {
        LOG.info("weixin.post===call");
        // 将请求、响应的编码均设置为UTF-8（防止中文乱码）
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        // 调用核心业务类接收消息、处理消息
        String respMessage = coreService.processRequest(request);
        LOG.info("weixin.post===respMessage:" + respMessage);
        // 响应消息
        PrintWriter out = response.getWriter();
        out.print(respMessage);
        if (out != null) {
            out.close();
        }
    }


}
