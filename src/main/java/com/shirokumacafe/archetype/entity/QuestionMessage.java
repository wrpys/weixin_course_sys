package com.shirokumacafe.archetype.entity;

import java.util.Date;

public class QuestionMessage extends Message {

    private Integer studentId;
    private String studentName;
    private String studentContent;
    private Date studentCreateTime;

    private Integer teacherId;
    private String teacherName;
    private String teacherContent;
    private Date teacherCreateTime;

    private String wWorkName;

    public Integer getStudentId() {
        return studentId;
    }

    public void setStudentId(Integer studentId) {
        this.studentId = studentId;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getStudentContent() {
        return studentContent;
    }

    public void setStudentContent(String studentContent) {
        this.studentContent = studentContent;
    }

    public Date getStudentCreateTime() {
        return studentCreateTime;
    }

    public void setStudentCreateTime(Date studentCreateTime) {
        this.studentCreateTime = studentCreateTime;
    }

    public Integer getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(Integer teacherId) {
        this.teacherId = teacherId;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public String getTeacherContent() {
        return teacherContent;
    }

    public void setTeacherContent(String teacherContent) {
        this.teacherContent = teacherContent;
    }

    public Date getTeacherCreateTime() {
        return teacherCreateTime;
    }

    public void setTeacherCreateTime(Date teacherCreateTime) {
        this.teacherCreateTime = teacherCreateTime;
    }

    public String getwWorkName() {
        return wWorkName;
    }

    public void setwWorkName(String wWorkName) {
        this.wWorkName = wWorkName;
    }
}