package com.shirokumacafe.archetype.entity;

public class FileImage {
    private Integer fiId;

    private Integer fId;

    private String fiAddr;

    public Integer getFiId() {
        return fiId;
    }

    public void setFiId(Integer fiId) {
        this.fiId = fiId;
    }

    public Integer getfId() {
        return fId;
    }

    public void setfId(Integer fId) {
        this.fId = fId;
    }

    public String getFiAddr() {
        return fiAddr;
    }

    public void setFiAddr(String fiAddr) {
        this.fiAddr = fiAddr == null ? null : fiAddr.trim();
    }
}