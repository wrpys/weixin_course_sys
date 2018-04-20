package com.shirokumacafe.archetype.entity;

import java.util.Date;

public class WorkInfo {
    private Integer wiId;

    private Integer wId;

    private Integer sId;

    private Date wiAddTime;

    private String wIScore;

    public Integer getWiId() {
        return wiId;
    }

    public void setWiId(Integer wiId) {
        this.wiId = wiId;
    }

    public Integer getwId() {
        return wId;
    }

    public void setwId(Integer wId) {
        this.wId = wId;
    }

    public Integer getsId() {
        return sId;
    }

    public void setsId(Integer sId) {
        this.sId = sId;
    }

    public Date getWiAddTime() {
        return wiAddTime;
    }

    public void setWiAddTime(Date wiAddTime) {
        this.wiAddTime = wiAddTime;
    }

    public String getwIScore() {
        return wIScore;
    }

    public void setwIScore(String wIScore) {
        this.wIScore = wIScore == null ? null : wIScore.trim();
    }
}