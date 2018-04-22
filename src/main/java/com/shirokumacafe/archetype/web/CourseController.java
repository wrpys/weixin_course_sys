package com.shirokumacafe.archetype.web;

import java.util.Date;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.shirokumacafe.archetype.common.Configs;
import com.shirokumacafe.archetype.common.mybatis.Page;
import com.shirokumacafe.archetype.common.utilities.Responses;
import com.shirokumacafe.archetype.entity.Course;
import com.shirokumacafe.archetype.service.CourseService;
import com.shirokumacafe.archetype.service.UserService;

/**
 * 课程管理
 */
@Controller
@RequestMapping("/course")
public class CourseController {

    @Autowired
    private CourseService courseService;
    @Autowired
    private UserService userService;

    @RequestMapping
    public String to(Model model){
        model.addAttribute("users",userService.getUsersByRoleId(Configs.CUSTOMER_TEACHER));
        return "course";
    }
    
    
    @RequestMapping(value = "add",method = RequestMethod.POST)
    @ResponseBody
    public Map<?,?> add(Course course){
        courseService.add(course);
        return Responses.writeSuccess();
    }
    
    
    @RequestMapping(value = "delete",method = RequestMethod.POST)
    @ResponseBody
    public Map<?,?> delete(@RequestParam(value = "ids") List<Integer> ids){
        courseService.deleteCourseList(ids);
        return Responses.writeSuccess();
    }
    
    
    @RequestMapping(value = "update",method = RequestMethod.POST)
    @ResponseBody
    public Map<?,?> update(Course course){
        courseService.update(course);
        return Responses.writeSuccess();
    }
    
    @RequestMapping(value = "list",method = RequestMethod.GET)
    @ResponseBody
    public String list(Course course, Date startDate, Date endDate, Page<Course> page){
        Page<Course> viewCoursePage = courseService.listCourse(course,startDate,endDate,page);
        return Responses.writeJson(viewCoursePage);
    }
}
