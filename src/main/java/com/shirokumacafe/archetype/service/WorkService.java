package com.shirokumacafe.archetype.service;

import com.github.pagehelper.PageHelper;
import com.shirokumacafe.archetype.common.Users;
import com.shirokumacafe.archetype.common.mybatis.Page;
import com.shirokumacafe.archetype.common.utilities.Responses;
import com.shirokumacafe.archetype.entity.Clzss;
import com.shirokumacafe.archetype.entity.Question;
import com.shirokumacafe.archetype.entity.QuestionMessage;
import com.shirokumacafe.archetype.entity.StuQuestionExt;
import com.shirokumacafe.archetype.entity.Student;
import com.shirokumacafe.archetype.entity.User;
import com.shirokumacafe.archetype.entity.Work;
import com.shirokumacafe.archetype.entity.WorkExt;
import com.shirokumacafe.archetype.entity.WorkInfo;
import com.shirokumacafe.archetype.entity.WorkQuestion;
import com.shirokumacafe.archetype.entity.WorkQuestionExt;
import com.shirokumacafe.archetype.repository.ClzssMapper;
import com.shirokumacafe.archetype.repository.StuQuestionMapper;
import com.shirokumacafe.archetype.repository.StudentMapper;
import com.shirokumacafe.archetype.repository.WorkInfoMapper;
import com.shirokumacafe.archetype.repository.WorkMapper;
import com.shirokumacafe.archetype.repository.WorkQuestionMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 作业管理：出作业题，查看作业结果，统计分析作业情况
 *
 * @author CZX
 */
@Service
@Transactional
public class WorkService {

    @Autowired
    private WorkMapper workMapper;

    @Autowired
    private WorkInfoMapper workInfoMapper;

    @Autowired
    private StudentMapper studentMapper;

    @Autowired
    private ClzssMapper clzssMapper;

    @Autowired
    private Users sessionUsers;

    @Autowired
    private WorkQuestionMapper workQuestionMapper;

    @Autowired
    private StuQuestionMapper stuQuestionMapper;

    @Autowired
    private MessageService messageService;

    /**
     * 添加作业
     *
     * @param work
     * @author CZX
     */
    public void add(Work work, String grade, String clzss) {
        User user = sessionUsers.getCurrentUser();
        Clzss clz = clzssMapper.selectClzssByGradeAndClzss(grade, clzss);
        work.setUserTchId(user.getUserId());
        work.setwAddTime(new Date());
        work.setClzssId(clz.getId());
        workMapper.insert(work);
    }

    /**
     * 获取所有发布的作业
     *
     * @return
     */
    public Page<Work> list(Work work, Page<Work> page) {
        com.github.pagehelper.Page<?> pageHelper = PageHelper.startPage(page.getPageIndex(), page.getLimit());
        List<Work> workList = workMapper.selectByParams(work);
        page.setRows(workList);
        page.setResults((int) pageHelper.getTotal());
        return page;
    }

    /**
     * 获取所有发布的作业 教师
     *
     * @return
     */
    public Page<WorkExt> listExtAll(Page<WorkExt> page) {
        com.github.pagehelper.Page<?> pageHelper = PageHelper.startPage(page.getPageIndex(), page.getLimit());
        List<WorkExt> workList = workMapper.selectByExtParams(new Work());
        page.setRows(workList);
        page.setResults((int) pageHelper.getTotal());
        return page;
    }

    /**
     * 修改作业
     *
     * @param work
     * @author CZX
     */
    public void update(Work work, String grade, String clzss) {
        User user = sessionUsers.getCurrentUser();
        Clzss clz = clzssMapper.selectClzssByGradeAndClzss(grade, clzss);
        work.setUserTchId(user.getUserId());
        work.setwAddTime(new Date());
        work.setClzssId(clz.getId());
        workMapper.updateByPrimaryKeySelective(work);
    }

    /**
     * 删除作业
     *
     * @param ids
     * @author CZX
     */
    public void delete(List<Integer> ids) {
        workMapper.deleteWorkList(ids);
    }

    /**
     * 根据作业信息ID和studen_id获取
     *
     * @param workInfo
     * @return
     * @author CZX
     */
    public WorkInfo getWorkInfoByWiIdAndStuId(WorkInfo workInfo) {
        return workInfoMapper.getWorkInfoByWiIdAndStuId(workInfo);
    }

    public List<Student> getWorkAnalysis(Work work) {
        List<Student> stuList = studentMapper.getWorkAnalysis(work);
        return stuList;
    }

    /**
     * 获取所有要做作业的学生列表信息:clzssId来获取所有应该提交的studentId
     *
     * @param work
     * @return
     * @author CZX
     */
    public List<Student> getAllToDoWorkList(Work work) {
        Student student = new Student();
        student.setClzssId(work.getClzssId());
        List<Student> stuList = studentMapper.selectByParams(student);
        return stuList;
    }

    public Work getWork(Integer wId) {
        return workMapper.selectByPrimaryKey(wId);
    }

    public Page<WorkQuestionExt> findWorkQuestion(WorkQuestionExt workQuestionExt, Page<WorkQuestionExt> page) {
        com.github.pagehelper.Page<?> pageHelper = PageHelper.startPage(page.getPageIndex(), page.getLimit());
        List<WorkQuestionExt> rows = workQuestionMapper.findWorkQuestionExtByParams(workQuestionExt);
        page.setRows(rows);
        page.setResults((int) pageHelper.getTotal());
        return page;
    }

    public Map addWorkQuestion(WorkQuestion workQuestion) {
        WorkQuestionExt workQuestionExt = new WorkQuestionExt();
        workQuestionExt.setwId(workQuestion.getwId());
        workQuestionExt.setqId(workQuestion.getqId());
        List<WorkQuestionExt> rows = workQuestionMapper.findWorkQuestionExtByParams(workQuestionExt);
        if (rows != null && rows.size() >= 1) {
            return Responses.writeFailAndMsg("该题目已存在！");
        }
        workQuestionMapper.insert(workQuestion);
        return Responses.writeSuccess();
    }

    public void deleteWorkQuestion(Integer wqId) {
        workQuestionMapper.deleteByPrimaryKey(wqId);
    }

    public List<StuQuestionExt> getQuestionDesc(Integer wId, Integer sId) {
        return stuQuestionMapper.getQuestionDesc(wId, sId);
    }

    public void getWorkExt(Integer wId, Model model) {
        Work work = new Work();
        work.setwId(wId);
        List<WorkExt> works = workMapper.selectByExtParams(work);
        model.addAttribute("work", works.get(0));
        WorkInfo workInfoParams = new WorkInfo();
        workInfoParams.setwId(wId);
        workInfoParams.setsId(sessionUsers.getStudent().getsId());
        WorkInfo workInfo = workInfoMapper.getWorkInfoByWIdAndStuId(workInfoParams);
        if (workInfo == null || StringUtils.isEmpty(workInfo.getwIScore())) {
            model.addAttribute("isComplete", false);
        } else {
            model.addAttribute("isComplete", true);
            model.addAttribute("workInfo", workInfo);
        }
    }

    public String getWorkReply(Integer wId, Model model) {
        model.addAttribute("work", workMapper.selectByPrimaryKey(wId));
        QuestionMessage questionMessage = new QuestionMessage();
        questionMessage.setwId(wId);
        List<QuestionMessage> replyList = messageService.questionMessageList(questionMessage);
        if (CollectionUtils.isEmpty(replyList)) {
            return "front/work_questions";
        } else {
            model.addAttribute("qms", replyList);
            return "front/work_reply";
        }
    }

    public WorkInfo getWorkScore(Integer workId) {
        WorkInfo workInfo = new WorkInfo();
        workInfo.setwId(workId);
        workInfo.setsId(sessionUsers.getStudent().getsId());
        return workInfoMapper.getWorkInfoByWIdAndStuId(workInfo);
    }

    public List<Question> getQuestionAnswers(int workId) {
        Student stu = sessionUsers.getStudent();
        int stuId = stu.getsId();
        List<Question> questionList = workMapper.getQuestionAnswers(workId,stuId);
        return questionList;
    }

}
