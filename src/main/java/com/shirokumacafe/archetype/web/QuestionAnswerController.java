package com.shirokumacafe.archetype.web;

import com.shirokumacafe.archetype.common.mybatis.Page;
import com.shirokumacafe.archetype.common.utilities.Responses;
import com.shirokumacafe.archetype.entity.Answer;
import com.shirokumacafe.archetype.entity.Question;
import com.shirokumacafe.archetype.service.QuestionAnswerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

/**
 * @since 2018/4/8
 */
@Controller
@RequestMapping(value = "/questionAnswer")
public class QuestionAnswerController {

    @Autowired
    private QuestionAnswerService questionAnswerService;

    @RequestMapping
    public String toQuestionAnswer() {
        return "questionAnswer";
    }

    @RequestMapping(value = "questionList", method = RequestMethod.GET)
    @ResponseBody
    public String questionList(Question question, Page page) {
        Page<Question> questionPage = questionAnswerService.questionPage(question, page);
        return Responses.writeJson(questionPage);
    }

    @RequestMapping(value = "addQuestion", method = RequestMethod.POST)
    @ResponseBody
    public Map addQuestion(Question question) {
        questionAnswerService.addQuestion(question, null);
        return Responses.writeSuccess();
    }

    @RequestMapping(value = "updateQuestion", method = RequestMethod.POST)
    @ResponseBody
    public Map updateQuestion(Question question) {
        questionAnswerService.updateQuestion(question, null);
        return Responses.writeSuccess();
    }

    @RequestMapping(value = "deleteQuestion", method = RequestMethod.POST)
    @ResponseBody
    public Map delete(Integer qId) {
        questionAnswerService.deleteQuestion(qId);
        return Responses.writeSuccess();
    }

    @RequestMapping("toAnswer")
    public String toAnswer(Model model, Integer qId, Integer qType) {
        model.addAttribute("qId", qId);
        model.addAttribute("qType", qType);
        return "answer";
    }

    @RequestMapping(value = "answerList", method = RequestMethod.GET)
    @ResponseBody
    public String answerList(Answer answer) {
        List<Answer> list = questionAnswerService.queryAnswer(answer);
        return Responses.writeJson(list);
    }

    @RequestMapping(value = "addAnswer", method = RequestMethod.POST)
    @ResponseBody
    public Map addAnswer(Answer answer) {
        questionAnswerService.addAnswer(answer);
        return Responses.writeSuccess();
    }

    @RequestMapping(value = "updateAnswer", method = RequestMethod.POST)
    @ResponseBody
    public Map updateAnswer(Answer answer) {
        questionAnswerService.updateAnswer(answer);
        return Responses.writeSuccess();
    }

    @RequestMapping(value = "deleteAnswer", method = RequestMethod.POST)
    @ResponseBody
    public Map deleteAnswer(Integer aId) {
        questionAnswerService.deleteAnswer(aId);
        return Responses.writeSuccess();
    }


}
