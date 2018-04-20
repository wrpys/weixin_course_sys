package com.shirokumacafe.archetype.entity;

import java.util.List;

/**
 * @since 2018/4/12
 */
public class WorkQuestionExt extends  WorkQuestion {

    private String wWorkName;
    private String qTitle;
    private Integer qType;

    private List<Answer> answers;

    public String getwWorkName() {
        return wWorkName;
    }

    public void setwWorkName(String wWorkName) {
        this.wWorkName = wWorkName;
    }

    public String getqTitle() {
        return qTitle;
    }

    public void setqTitle(String qTitle) {
        this.qTitle = qTitle;
    }

    public Integer getqType() {
        return qType;
    }

    public void setqType(Integer qType) {
        this.qType = qType;
    }

    public List<Answer> getAnswers() {
        return answers;
    }

    public void setAnswers(List<Answer> answers) {
        this.answers = answers;
    }
}
