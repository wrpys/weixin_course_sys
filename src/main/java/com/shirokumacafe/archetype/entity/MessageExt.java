package com.shirokumacafe.archetype.entity;

import java.util.List;

public class MessageExt extends Message {

    private String operRoleName;

    private String operName;

    private String chatHeadAddr;

    private List<MessageExt> messageExts;

    public String getOperRoleName() {
        return operRoleName;
    }

    public void setOperRoleName(String operRoleName) {
        this.operRoleName = operRoleName;
    }

    public String getOperName() {
        return operName;
    }

    public void setOperName(String operName) {
        this.operName = operName;
    }

    public String getChatHeadAddr() {
        return chatHeadAddr;
    }

    public void setChatHeadAddr(String chatHeadAddr) {
        this.chatHeadAddr = chatHeadAddr;
    }

    public List<MessageExt> getMessageExts() {
        return messageExts;
    }

    public void setMessageExts(List<MessageExt> messageExts) {
        this.messageExts = messageExts;
    }
}