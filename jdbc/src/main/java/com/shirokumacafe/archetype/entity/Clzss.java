package com.shirokumacafe.archetype.entity;

public class Clzss {
    private Integer id;

    private String grade;

    private String clzss;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade == null ? null : grade.trim();
    }

    public String getClzss() {
        return clzss;
    }

    public void setClzss(String clzss) {
        this.clzss = clzss == null ? null : clzss.trim();
    }
}