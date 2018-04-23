package com.shirokumacafe.archetype.entity;

import java.util.Date;

public class Message {
    private Integer msgId;

    private Integer msgPid;

    private String msgContent;

    private Date createTime;

    private Integer cId;

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
        this.msgContent = msgContent;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getcId() {
        return cId;
    }

    public void setcId(Integer cId) {
        this.cId = cId;
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
}