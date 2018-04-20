package com.shirokumacafe.archetype.service;

import com.github.pagehelper.PageHelper;
import com.shirokumacafe.archetype.common.Users;
import com.shirokumacafe.archetype.common.mybatis.Page;
import com.shirokumacafe.archetype.entity.Answer;
import com.shirokumacafe.archetype.entity.Question;
import com.shirokumacafe.archetype.entity.StuQuestion;
import com.shirokumacafe.archetype.entity.WorkInfo;
import com.shirokumacafe.archetype.entity.WorkQuestionExt;
import com.shirokumacafe.archetype.repository.AnswerMapper;
import com.shirokumacafe.archetype.repository.QuestionMapper;
import com.shirokumacafe.archetype.repository.StuQuestionMapper;
import com.shirokumacafe.archetype.repository.WorkInfoMapper;
import com.shirokumacafe.archetype.repository.WorkQuestionMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

/**
 * @since 2018/4/8
 */
@Service
@Transactional
public class QuestionAnswerService {

    @Autowired
    private QuestionMapper questionMapper;

    @Autowired
    private AnswerMapper answerMapper;

    @Autowired
    private WorkQuestionMapper workQuestionMapper;

    @Autowired
    private StuQuestionMapper stuQuestionMapper;

    @Autowired
    private WorkInfoMapper workInfoMapper;

    @Autowired
    private Users sessionUsers;

    @Autowired
    private HttpSession session;

    public Page<Question> questionPage(Question question, Page page) {
        com.github.pagehelper.Page pageHelper = PageHelper.startPage(page.getPageIndex(), page.getLimit());
        List<Question> questionList = questionMapper.selectByParams(question);
        page.setRows(questionList);
        page.setResults(Integer.valueOf(String.valueOf(pageHelper.getTotal())));
        return page;
    }

    public void addQuestion(Question question, List<Answer> answers) {
        questionMapper.insertSelective(question);
        if (!CollectionUtils.isEmpty(answers)) {
            for (int i = 0, len = answers.size(); i < len; i++) {
                Answer answer = answers.get(i);
                answer.setqId(question.getqId());
                answerMapper.insertSelective(answer);
            }
        }
    }

    public void updateQuestion(Question question, List<Answer> answers) {
        questionMapper.updateByPrimaryKeySelective(question);
        if (!CollectionUtils.isEmpty(answers)) {
            for (int i = 0, len = answers.size(); i < len; i++) {
                answerMapper.updateByPrimaryKey(answers.get(i));
            }
        }
    }

    public void deleteQuestion(Integer qId) {
        questionMapper.deleteByPrimaryKey(qId);
        Answer answer = new Answer();
        answer.setqId(qId);
        List<Answer> answers = this.queryAnswer(answer);
        if (!CollectionUtils.isEmpty(answers)) {
            for (int i = 0, len = answers.size(); i < len; i++) {
                answerMapper.deleteByPrimaryKey(answers.get(i).getaId());
            }
        }
    }

    public List<Answer> queryAnswer(Answer answer) {
        return answerMapper.selectByParams(answer);
    }

    public void addAnswer(Answer answer) {
        answerMapper.insertSelective(answer);
    }

    public void updateAnswer(Answer answer) {
        answerMapper.updateByPrimaryKey(answer);
    }

    public void deleteAnswer(Integer aId) {
        answerMapper.deleteByPrimaryKey(aId);
    }

    public void getQuestion(Integer wqId, Integer wId, Integer qId, String qAnswer, Model model) {
        WorkQuestionExt workQuestionExt = new WorkQuestionExt();

        workQuestionExt.setwId(wId);
        workQuestionExt.setWqId(wqId);
        PageHelper.startPage(1, 1);
        List<WorkQuestionExt> wqes = workQuestionMapper.findWorkQuestionExtByParams(workQuestionExt);
        if (wqId == null) {
            session.setAttribute("questionIndex", 1);
        } else {
            // 答题详情
            StuQuestion stuQuestion = new StuQuestion();
            stuQuestion.setsId(sessionUsers.getStudent().getsId());
            stuQuestion.setqId(qId);
            stuQuestion.setwId(wId);
            stuQuestion.setqAnswer(qAnswer);
            stuQuestionMapper.insertSelective(stuQuestion);
            // 分数计算 只有选择题纳入计算
            WorkInfo wi = new WorkInfo();
            wi.setwId(wId);
            wi.setsId(sessionUsers.getStudent().getsId());
            WorkInfo workInfo = workInfoMapper.getWorkInfoByWIdAndStuId(wi);
            if (workInfo == null) {
                wi.setwIScore("0");
                wi.setWiAddTime(new Date());
                workInfoMapper.insertSelective(wi);
            }

            // 只有单选题，才能计算分数
            Question question = questionMapper.selectByPrimaryKey(qId);
            if (question != null && question.getqType().intValue() == 1) {
                Answer answer = new Answer();
                answer.setqId(qId);
                List<Answer> answers = answerMapper.selectByParams(answer);
                boolean isCorrect = false;
                for (Answer item : answers) {
                    if (qAnswer.equals(item.getaAnswer()) && item.getaCorrect().intValue() == 1) {
                        isCorrect = true;
                        break;
                    }
                }

                if (isCorrect) {
                    workInfo = workInfoMapper.getWorkInfoByWIdAndStuId(wi);
                    workInfo.setwIScore(String.valueOf(Integer.valueOf(workInfo.getwIScore()) + 1));
                    workInfo.setWiAddTime(new Date());
                    workInfoMapper.updateByPrimaryKeySelective(workInfo);
                }
            }

        }

        if (wqes != null && !wqes.isEmpty()) {
            if (wqId != null) {
                Integer questionIndex = (Integer) session.getAttribute("questionIndex");
                session.setAttribute("questionIndex", questionIndex + 1);
            }

            WorkQuestionExt question = wqes.get(0);
            Answer answer = new Answer();
            answer.setqId(question.getqId());
            question.setAnswers(answerMapper.selectByParams(answer));
            model.addAttribute("question", question);
        } else {
            model.addAttribute("question", null);
        }
    }

}
