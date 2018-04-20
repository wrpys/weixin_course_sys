package com.shirokumacafe.archetype.entity;

/**
 * @since 2018/4/12
 */
public class StuQuestionExt extends StuQuestion {

    private String qTitle;

    private String correctAnswer;

    public String getqTitle() {
        return qTitle;
    }

    public void setqTitle(String qTitle) {
        this.qTitle = qTitle;
    }

    public String getCorrectAnswer() {
        return correctAnswer;
    }

    public void setCorrectAnswer(String correctAnswer) {
        this.correctAnswer = correctAnswer;
    }
}
