package com.shirokumacafe.archetype.model.req;

/**
 * 文本消息
 *
 * @author wrp
 * @since 2017/11/29
 */
public class ReqTextMessage extends ReqBaseMessage {

    //	文本消息内容
    private String Content;

    public String getContent() {
        return Content;
    }

    public void setContent(String content) {
        Content = content;
    }

}
