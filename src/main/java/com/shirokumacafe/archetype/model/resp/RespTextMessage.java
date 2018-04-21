package com.shirokumacafe.archetype.model.resp;

/**
 * 文本消息
 *
 * @author wrp
 * @since 2017/11/29
 */
public class RespTextMessage extends RespBaseMessage {

    // 回复的消息内容
    private String Content;

    public String getContent() {
        return Content;
    }

    public void setContent(String content) {
        Content = content;
    }
}
