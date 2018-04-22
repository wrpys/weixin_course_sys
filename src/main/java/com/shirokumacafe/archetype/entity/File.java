package com.shirokumacafe.archetype.entity;

public class File {
    private Integer fId;

    private String fName;

    private String fAddr;

    public Integer getfId() {
        return fId;
    }

    public void setfId(Integer fId) {
        this.fId = fId;
    }

    public String getfName() {
        return fName;
    }

    public void setfName(String fName) {
        this.fName = fName == null ? null : fName.trim();
    }

    public String getfAddr() {
        return fAddr;
    }

    public void setfAddr(String fAddr) {
        this.fAddr = fAddr == null ? null : fAddr.trim();
    }
}