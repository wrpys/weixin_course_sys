package com.shirokumacafe.archetype.entity;

import java.util.Date;

public class Work {
    private Integer wId;

    private Integer userTchId;

    private Integer clzssId;

    private String wWorkName;

    private Date wAddTime;

    private String wWorkRequirement;

    public Integer getwId() {
        return wId;
    }

    public void setwId(Integer wId) {
        this.wId = wId;
    }

    public Integer getUserTchId() {
        return userTchId;
    }

    public void setUserTchId(Integer userTchId) {
        this.userTchId = userTchId;
    }

    public Integer getClzssId() {
        return clzssId;
    }

    public void setClzssId(Integer clzssId) {
        this.clzssId = clzssId;
    }

    public String getwWorkName() {
        return wWorkName;
    }

    public void setwWorkName(String wWorkName) {
        this.wWorkName = wWorkName == null ? null : wWorkName.trim();
    }

    public Date getwAddTime() {
        return wAddTime;
    }

    public void setwAddTime(Date wAddTime) {
        this.wAddTime = wAddTime;
    }

    public String getwWorkRequirement() {
        return wWorkRequirement;
    }

    public void setwWorkRequirement(String wWorkRequirement) {
        this.wWorkRequirement = wWorkRequirement == null ? null : wWorkRequirement.trim();
    }
}