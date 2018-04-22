package com.shirokumacafe.archetype.service;

import com.alibaba.fastjson.JSON;
import com.shirokumacafe.archetype.common.utilities.Responses;
import com.shirokumacafe.archetype.common.utils.MessageUtil;
import com.shirokumacafe.archetype.common.utils.PropertiesUtil;
import com.shirokumacafe.archetype.entity.Student;
import com.shirokumacafe.archetype.entity.ViewUser;
import com.shirokumacafe.archetype.entity.ViewUserExample;
import com.shirokumacafe.archetype.model.req.ReqTextMessage;
import com.shirokumacafe.archetype.model.resp.Article;
import com.shirokumacafe.archetype.model.resp.RespNewsMessage;
import com.shirokumacafe.archetype.model.resp.RespTextMessage;
import com.shirokumacafe.archetype.repository.StudentMapper;
import com.shirokumacafe.archetype.repository.ViewUserMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.ArrayList;
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
            // 先查看该微信号是否是教师
            ViewUserExample example1 = new ViewUserExample();
            ViewUserExample.Criteria criteria1 = example1.createCriteria();
            criteria1.andWeixinIdEqualTo(reqTextMessage.getFromUserName());
            List<ViewUser> users = viewUserMapper.selectByExample(example1);
            // 是教师
            if (users != null && !users.isEmpty()) {
                ViewUser user = users.get(0);
                sb.append("【教师个人信息】").append("\n");
                sb.append("工号：").append(user.getLoginName()).append("\n");
                sb.append("姓名：").append(user.getNickName()).append("\n");
                sb.append("密码：").append(user.getPassword()).append("\n");
            }
            // 不是教师，就查看是否是学生
            else {
                Student params = new Student();
                params.setWeixinId(reqTextMessage.getFromUserName());
                List<Student> students = studentMapper.selectByParams(params);
                // 是学生
                if (students != null && !students.isEmpty()) {
                    Student student = students.get(0);
                    sb.append("【学生个人信息】").append("\n");
                    sb.append("学号：").append(student.getsNo()).append("\n");
                    sb.append("姓名：").append(student.getsName()).append("\n");
                    sb.append("密码：").append(student.getsPassword()).append("\n");
                }
                // 不是学生 进行绑定提示
                else {
                    sb.append("此微信未进行绑定,发送1进行绑定.").append("\n");
                }
            }
            respTextMessage.setContent(sb.toString());
            return MessageUtil.textMessageToXml(respTextMessage);
        } else if ("3".equals(reqTextMessage.getContent())) {
            RespNewsMessage newsMessage = new RespNewsMessage();
            newsMessage.setFromUserName(reqTextMessage.getToUserName());
            newsMessage.setToUserName(reqTextMessage.getFromUserName());
            newsMessage.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_NEWS);
            newsMessage.setFuncFlag(0);

            List<Article> articles = new ArrayList<>();
            Article article = new Article();
            article.setTitle("标题");
            article.setPicUrl("https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png");
            article.setUrl("https://www.baidu.com/");
            article.setDescription("测试描述");
            articles.add(article);

            article = new Article();
            article.setTitle("大家的事由大家商量着办——习近平主席致第四届世界互联网大会的贺信引起与会中外嘉宾热烈反响");
//          article.setPicUrl("https://mp.weixin.qq.com/misc/getqrcode?fakeid=3074025666&token=205380857&style=1");
            article.setUrl("https://mbd.baidu.com/newspage/data/landingsuper?context=%7B%22nid%22%3A%22news_15464600260927191937%22%7D&n_type=0&p_from=1");
            article.setDescription("大家的事由大家商量着办——习近平主席致第四届世界互联网大会的贺信引起与会中外嘉宾热烈反响");
            articles.add(article);

            article = new Article();
            article.setTitle("某网友吃冰激凌吃出一条真蛇，他真的很无耻！");
            article.setPicUrl("https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=1192839229,3053310621&fm=173&s=DDFE34D7560046E204B6A9740300D06B&w=640&h=397&img.JPEG");
            article.setUrl("https://mbd.baidu.com/newspage/data/landingsuper?context=%7B%22nid%22%3A%22news_9860825529527486302%22%7D&n_type=0&p_from=1");
            article.setDescription("某网友吃冰激凌吃出一条真蛇，他真的很无耻！");
            articles.add(article);

            String baseUrl = "http://fdf2f3b7.ngrok.io";
            article = new Article();
            article.setTitle("wrpys");
            article.setUrl(baseUrl + "/index");
            article.setPicUrl(baseUrl + "/common/images/erweima.jpg");
            article.setDescription("wrpys微信公众号");
            articles.add(article);

            article = new Article();
            article.setTitle("wrpys头像");
            article.setUrl(baseUrl + "/index");
            article.setPicUrl(baseUrl + "/common/images/wrpys_icon.jpg");
            article.setDescription("wrpys微信公众号头像");
            articles.add(article);

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
