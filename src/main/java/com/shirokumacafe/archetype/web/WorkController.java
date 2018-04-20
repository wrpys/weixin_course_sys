package com.shirokumacafe.archetype.web;

import com.github.pagehelper.PageHelper;
import com.shirokumacafe.archetype.common.Configs;
import com.shirokumacafe.archetype.common.mybatis.Page;
import com.shirokumacafe.archetype.common.utilities.Responses;
import com.shirokumacafe.archetype.entity.StuQuestion;
import com.shirokumacafe.archetype.entity.StuQuestionExt;
import com.shirokumacafe.archetype.entity.Student;
import com.shirokumacafe.archetype.entity.User;
import com.shirokumacafe.archetype.entity.Work;
import com.shirokumacafe.archetype.entity.WorkInfo;
import com.shirokumacafe.archetype.entity.WorkQuestion;
import com.shirokumacafe.archetype.entity.WorkQuestionExt;
import com.shirokumacafe.archetype.service.UserService;
import com.shirokumacafe.archetype.service.WorkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

/**
 * 作业管理：出作业题，查看作业结果，统计分析作业情况
 * @author CZX
 *
 */
@Controller
@RequestMapping("/work")
public class WorkController {

    @Autowired
    private WorkService workService;
    @Autowired
    private UserService userService;
    
    @RequestMapping
    public String to(Model model){
    	List<User> users = userService.getUsersByRoleId(Configs.CUSTOMER_TEACHER);
    	users.addAll(userService.getUsersByRoleId(Configs.CUSTOMER_AMIN));
        model.addAttribute("users",users);
        return "work";
    }
    
    /**
     * 出作业题
     * @param work
     * @return
     */
    @RequestMapping(value = "add",method = RequestMethod.POST)
    @ResponseBody
    public Map<?,?> add(Work work,String grade,String clzss){
        workService.add(work,grade,clzss);
        return Responses.writeSuccess();
    }
    
    /**
     * 查看所有作业发布情况
     * @author CZX
     * @param work
     * @param startDate
     * @param endDate
     * @param page
     * @return
     */
    @RequestMapping(value = "list",method = RequestMethod.GET)
    @ResponseBody
    public String list(Work work, Page<Work> page){
        return Responses.writeJson(workService.list(work, page));
    }
    
    /**
     * 修改作业
     * @author CZX
     * @param work
     * @return
     */
    @RequestMapping(value = "update",method = RequestMethod.POST)
    @ResponseBody
    public Map<?,?> update(Work work,String grade,String clzss){
        workService.update(work,grade,clzss);
        return Responses.writeSuccess();
    }
    
    /**
     * 删除作业
     * @author CZX
     * @param ids
     * @return
     */
    @RequestMapping(value = "delete",method = RequestMethod.POST)
    @ResponseBody
    public Map<?,?> delete(@RequestParam(value = "ids")List<Integer> ids){
        workService.delete(ids);
        return Responses.writeSuccess();
    }
    
    /**
     * 查看作业结果
     * @author CZX  
     * @param workInfo
     * @return
     */
    @RequestMapping(value = "getWorkResult",method = RequestMethod.POST)
    @ResponseBody
    public String getWorkResult(WorkInfo workInfo){
    	WorkInfo result = workService.getWorkInfoByWiIdAndStuId(workInfo);
        return Responses.writeJson(result);
    }
    



    /**
     * 跳转至作业分析
     * @author CZX
     * @param work
     * @return
     */
    @RequestMapping("toWorkAnalysis")
    public String toAnswer(Model model, Integer wId, Integer clzssId) {
        model.addAttribute("wId", wId);
        model.addAttribute("clzssId", clzssId);
        return "workAnalysis";
    }
    
    /**
     * 统计分析作业情况
     * @author CZX
     * @param work
     * @return
     */
    @RequestMapping(value = "getWorkAnalysis",method = RequestMethod.GET)
    @ResponseBody
    public String getWorkAnalysis(Work work,Page<Student> page){
    	com.github.pagehelper.Page<?> pageHelper = PageHelper.startPage(page.getPageIndex(), page.getLimit());
    	List<Student> stuList = workService.getWorkAnalysis(work);
    	page.setRows(stuList);
        page.setResults((int)pageHelper.getTotal());
        return Responses.writeJson(page);
    }

    @RequestMapping("toWorkQuestion")
    public String toWorkQuestion(Model model, Integer wId) {
        model.addAttribute("wId", wId);
        return "workQuestion";
    }

    @RequestMapping(value = "workQuestionList",method = RequestMethod.GET)
    @ResponseBody
    public String workQuestionList(WorkQuestionExt workQuestionExt, Page<WorkQuestionExt> page) {
        Page<WorkQuestionExt> workQuestionExtPage = workService.findWorkQuestion(workQuestionExt, page);
        return Responses.writeJson(workQuestionExtPage);
    }

    @RequestMapping(value = "addWorkQuestion",method = RequestMethod.POST)
    @ResponseBody
    public Map addWorkQuestion(WorkQuestion workQuestion) {
        return workService.addWorkQuestion(workQuestion);
    }

    @RequestMapping(value = "deleteWorkQuestion",method = RequestMethod.POST)
    @ResponseBody
    public Map deleteWorkQuestion(Integer wqId) {
        workService.deleteWorkQuestion(wqId);
        return Responses.writeSuccess();
    }

    @RequestMapping("toQuestionDesc")
    public String toQuestionDesc(Model model, Integer wId, Integer sId) {
        model.addAttribute("wId", wId);
        model.addAttribute("sId", sId);
        return "questionDesc";
    }

    @RequestMapping("getQuestionDesc")
    @ResponseBody
    public String getQuestionDesc(Integer wId, Integer sId) {
        List<StuQuestionExt> stuQuestionExts = workService.getQuestionDesc(wId, sId);
        return Responses.writeJson(stuQuestionExts);
    }

}
