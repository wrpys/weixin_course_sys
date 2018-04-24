package com.shirokumacafe.archetype.service;

import com.alibaba.fastjson.JSON;
import com.shirokumacafe.archetype.common.utils.MessageUtil;
import com.shirokumacafe.archetype.common.utils.PropertiesUtil;
import com.shirokumacafe.archetype.entity.CourseExt;
import com.shirokumacafe.archetype.entity.Student;
import com.shirokumacafe.archetype.entity.ViewUser;
import com.shirokumacafe.archetype.entity.ViewUserExample;
import com.shirokumacafe.archetype.model.WeixinUserInfo;
import com.shirokumacafe.archetype.model.req.ReqTextMessage;
import com.shirokumacafe.archetype.model.resp.Article;
import com.shirokumacafe.archetype.model.resp.RespNewsMessage;
import com.shirokumacafe.archetype.model.resp.RespTextMessage;
import com.shirokumacafe.archetype.repository.CourseMapper;
import com.shirokumacafe.archetype.repository.StudentMapper;
import com.shirokumacafe.archetype.repository.ViewUserMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 请求消息处理 文本
 *
 * @author wrp
 * @since 2017/12/5
 */
@Service("textMessageHandleService")
public class TextMessageHandleService {

    private static final Logger LOG = LoggerFactory.getLogger(TextMessageHandleService.class);

    @Autowired
    private HttpServletRequest request;
    @Autowired
    private StudentMapper studentMapper;
    @Autowired
    private ViewUserMapper viewUserMapper;
    @Autowired
    private CourseMapper courseMapper;
    @Autowired
    private FrontService frontService;

    public String handle(Map<String, String> reqMsg) {
        ReqTextMessage reqTextMessage = new ReqTextMessage();
        MessageUtil.mapToObject(reqMsg, reqTextMessage);
        LOG.info("reqTextMessage:" + JSON.toJSONString(reqTextMessage));
        // 菜单
        if ("菜单".equals(reqTextMessage.getContent())) {
            RespTextMessage respTextMessage = new RespTextMessage();
            respTextMessage.setFromUserName(reqTextMessage.getToUserName());
            respTextMessage.setToUserName(reqTextMessage.getFromUserName());
            respTextMessage.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_TEXT);
            respTextMessage.setFuncFlag(0);
            StringBuffer sb = new StringBuffer();
            sb.append("【菜单列表】").append("\n");
            sb.append("发送1进行绑定").append("\n");
            sb.append("发送2查看个人信息").append("\n");
            sb.append("发送3获取课程列表").append("\n");
            respTextMessage.setContent(sb.toString());
            return MessageUtil.textMessageToXml(respTextMessage);
        }
        // 进行绑定
        else if ("1".equals(reqTextMessage.getContent())) {
            RespTextMessage respTextMessage = new RespTextMessage();
            respTextMessage.setFromUserName(reqTextMessage.getToUserName());
            respTextMessage.setToUserName(reqTextMessage.getFromUserName());
            respTextMessage.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_TEXT);
            respTextMessage.setFuncFlag(0);
            String content = "";
            try {
                String wwwRoot = PropertiesUtil.getProperties().getProperty("www.root");
                String bindingPageUrl = wwwRoot + request.getContextPath() + "/front/toBinding?weixinId=" + reqTextMessage.getFromUserName();
                LOG.info("===bindingPageUrl===" + bindingPageUrl);
                content = "<a href=\"" + bindingPageUrl + "\">绑定系统账号</a>";
            } catch (IOException e) {
                LOG.error("读取文件异常。", e);
                content = "服务异常，请稍后重试！";
            }
            respTextMessage.setContent(content);
            return MessageUtil.textMessageToXml(respTextMessage);
        }
        // 查看个人信息
        else if ("2".equals(reqTextMessage.getContent())) {
            RespTextMessage respTextMessage = new RespTextMessage();
            respTextMessage.setFromUserName(reqTextMessage.getToUserName());
            respTextMessage.setToUserName(reqTextMessage.getFromUserName());
            respTextMessage.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_TEXT);
            respTextMessage.setFuncFlag(0);
            StringBuffer sb = new StringBuffer();

            WeixinUserInfo weixinUserInfo = frontService.getWeixinUserInfo(reqTextMessage.getFromUserName());
            if (weixinUserInfo != null) {
                if (1 == weixinUserInfo.getRole().intValue()) {
                    sb.append("【学生个人信息】").append("\n");
                    sb.append("学号：").append(weixinUserInfo.getAccount()).append("\n");
                    sb.append("姓名：").append(weixinUserInfo.getUserName()).append("\n");
                    sb.append("密码：").append(weixinUserInfo.getPassword()).append("\n");
                } else {
                    sb.append("【教师个人信息】").append("\n");
                    sb.append("工号：").append(weixinUserInfo.getAccount()).append("\n");
                    sb.append("姓名：").append(weixinUserInfo.getUserName()).append("\n");
                    sb.append("密码：").append(weixinUserInfo.getPassword()).append("\n");
                }
            } else {
                sb.append("此微信未进行绑定,发送1进行绑定.").append("\n");
            }

            respTextMessage.setContent(sb.toString());
            return MessageUtil.textMessageToXml(respTextMessage);
        } else if ("3".equals(reqTextMessage.getContent())) {
            Map<String, Object> params = new HashMap<>();
            params.put("cPid", 0);
            List<CourseExt> courseList = courseMapper.listByParams(params);
            RespTextMessage respTextMessage = new RespTextMessage();
            respTextMessage.setFromUserName(reqTextMessage.getToUserName());
            respTextMessage.setToUserName(reqTextMessage.getFromUserName());
            respTextMessage.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_TEXT);
            respTextMessage.setFuncFlag(0);
            if (courseList == null || courseList.isEmpty()) {
                respTextMessage.setContent("暂无课程，尽请期待！");
                return MessageUtil.textMessageToXml(respTextMessage);
            }

            String contentPath = "";
            try {
                contentPath = PropertiesUtil.getProperties().getProperty("www.root")  + request.getContextPath();
            } catch (IOException e) {
                LOG.error("读取文件异常。", e);
                respTextMessage.setContent("服务异常，请稍后重试！");
                return MessageUtil.textMessageToXml(respTextMessage);
            }

            RespNewsMessage newsMessage = new RespNewsMessage();
            newsMessage.setFromUserName(reqTextMessage.getToUserName());
            newsMessage.setToUserName(reqTextMessage.getFromUserName());
            newsMessage.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_NEWS);
            newsMessage.setFuncFlag(0);

            List<Article> articles = new ArrayList<>();

            for (int i = 0; i < courseList.size(); i++) {
                Article article = new Article();
                CourseExt course = courseList.get(i);
                article.setTitle(course.getcName());
                article.setUrl(contentPath + "/front/toCourse?cId=" + course.getcId() + "&weixinId=" + reqTextMessage.getFromUserName());
                articles.add(article);
            }
            newsMessage.setArticles(articles);
            newsMessage.setArticleCount(articles.size());
            return MessageUtil.newsMessageToXml(newsMessage);
        } else {
            RespTextMessage respTextMessage = new RespTextMessage();
            respTextMessage.setFromUserName(reqTextMessage.getToUserName());
            respTextMessage.setToUserName(reqTextMessage.getFromUserName());
            respTextMessage.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_TEXT);
            respTextMessage.setFuncFlag(0);
            StringBuffer sb = new StringBuffer();
            sb.append("未知内容，请发送【菜单】查看更多信息");
            respTextMessage.setContent(sb.toString());
            return MessageUtil.textMessageToXml(respTextMessage);
        }
    }
}
