//package com.shirokumacafe.archetype.web;
//
//import com.shirokumacafe.archetype.common.mybatis.Page;
//import com.shirokumacafe.archetype.common.utilities.Responses;
//import com.shirokumacafe.archetype.entity.Course;
//import com.shirokumacafe.archetype.entity.ViewCourse;
//import com.shirokumacafe.archetype.pattern.Configs;
//import com.shirokumacafe.archetype.service.CourseService;
//import com.shirokumacafe.archetype.service.UserService;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.ResponseBody;
//
//import java.util.Date;
//import java.util.List;
//import java.util.Map;
//
///**
// * 课程管理
// * User: wrp
// * Date: 14-12-30
// * Time: 下午10:50
// */
//@Controller
//@RequestMapping("/course")
//public class CourseController {
//
//    @Autowired
//    private CourseService courseService;
//    @Autowired
//    private UserService userService;
//    @Autowired
//    private DepartmentService departmentService;
//
//    @RequestMapping
//    public String to(Model model){
//        model.addAttribute("attendAddrs",attendAddService.getAttendAddrByAaPid(0));
//        model.addAttribute("users",userService.getUsersByRoleId(Configs.CUSTOMER_TEACHER));
//        model.addAttribute("departments",departmentService.getParentDepartment());
//        return "course";
//    }
//
//    @RequestMapping(value = "list",method = RequestMethod.GET)
//    @ResponseBody
//    public String list(Course course, Date startDate, Date endDate, Page page){
//        Page<ViewCourse> viewCoursePage = courseService.list(course,startDate,endDate,page);
//        return Responses.writeJson(viewCoursePage);
//    }
//
//    @RequestMapping(value = "add",method = RequestMethod.POST)
//    @ResponseBody
//    public Map add(Course course){
//        courseService.add(course);
//        return Responses.writeSuccess();
//    }
//
//    @RequestMapping(value = "update",method = RequestMethod.POST)
//    @ResponseBody
//    public Map update(Course course){
//        courseService.update(course);
//        return Responses.writeSuccess();
//    }
//
//    @RequestMapping(value = "delete",method = RequestMethod.POST)
//    @ResponseBody
//    public Map delete(@RequestParam(value = "ids") List<Integer> ids){
//        courseService.delete(ids);
//        return Responses.writeSuccess();
//    }
//
///**********************上课时间***************************************************************/
//    @RequestMapping(value = "getCourseTimeByCId",method = RequestMethod.POST)
//    @ResponseBody
//    public String getCourseTimeByCId(Integer cId){
//        return Responses.writeJson(courseService.getCourseTimeByCId(cId));
//    }
//
//    @RequestMapping(value = "updateCourseTime",method = RequestMethod.POST)
//    @ResponseBody
//    public Map updateCourseTime(Integer cId, @RequestParam(value = "ctIdAndTimes") List<String> ctIdAndTimes, @RequestParam(value = "ctIds") List<Integer> ctIds){
//        courseService.deleteCourseTime(ctIds);
//        courseService.updateCourseTime(cId,ctIdAndTimes);
//        return Responses.writeSuccess();
//    }
//
//    /**
//     * 上课时间列表
//     * @param cId
//     * @param page
//     * @return
//     */
//    @RequestMapping(value = "courseTimeList",method = RequestMethod.GET)
//    @ResponseBody
//    public String courseTimeList(Integer cId, Page page){
//        return Responses.writeJson(courseService.courseTimeList(cId,page));
//    }
//
//}
