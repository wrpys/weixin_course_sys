package com.shirokumacafe.archetype.entity;

import java.util.Date;

public class Message {
    private Integer msgId;

    private Integer msgPid;

    private Integer msgType;

    private String msgContent;

    private Date createTime;

    private Integer wId;

    private Integer operRole;

    private Integer operId;

    public Integer getMsgId() {
        return msgId;
    }

    public void setMsgId(Integer msgId) {
        this.msgId = msgId;
    }

    public Integer getMsgPid() {
        return msgPid;
    }

    public void setMsgPid(Integer msgPid) {
        this.msgPid = msgPid;
    }

    public String getMsgContent() {
        return msgContent;
    }

    public void setMsgContent(String msgContent) {
        this.msgContent = msgContent == null ? null : msgContent.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getwId() {
        return wId;
    }

    public void setwId(Integer wId) {
        this.wId = wId;
    }

    public Integer getOperRole() {
        return operRole;
    }

    public void setOperRole(Integer operRole) {
        this.operRole = operRole;
    }

    public Integer getOperId() {
        return operId;
    }

    public void setOperId(Integer operId) {
        this.operId = operId;
    }

    public Integer getMsgType() {
        return msgType;
    }

    public void setMsgType(Integer msgType) {
        this.msgType = msgType;
    }
}