package com.shirokumacafe.archetype.web.api;

import com.shirokumacafe.archetype.common.utilities.Responses;
import com.shirokumacafe.archetype.entity.Course;
import com.shirokumacafe.archetype.entity.Message;
import com.shirokumacafe.archetype.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.List;
import java.util.Map;

/**
 * 前台入口
 */
@Controller
    @RequestMapping(value = "/front")
public class FrontAction {

    @Autowired
    private StudentService studentService;
    @Autowired
    private UserService userService;
    @Autowired
    private MessageService messageService;
    @Autowired
    private CourseService courseService;
    @Autowired
    private FileService fileService;

    /**
     * 跳转到绑定页面
     */
    @RequestMapping(value = "toBinding", method = RequestMethod.GET)
    public String toBinding(String weixinId, Model model) {
        model.addAttribute("weixinId", weixinId);
        return "front/binding";
    }

    /**
     * 绑定
     *
     * @param weixinId 微信ID
     * @param operRole 角色：1.学生，2.教师
     * @param account  账号
     * @param model
     * @return
     */
    @RequestMapping(value = "binding", method = RequestMethod.POST)
    public String binding(String weixinId, Integer operRole, String account, Model model) {
        Map result = null;
        if (operRole.intValue() == 1) {
            result = studentService.binding(weixinId, account);
        } else if (operRole.intValue() == 2) {
            result = userService.binding(weixinId, account);
        }
        boolean isSucess = Boolean.valueOf(String.valueOf(result.get("success")));
        if (isSucess) {
            model.addAttribute("msg", "绑定成功");
            return "front/success";
        } else {
            model.addAttribute("weixinId", weixinId);
            model.addAttribute("msg", result.get("msg"));
            return "front/binding";
        }
    }

    /**
     * 课程详情
     *
     * @param cId
     * @param weixinId
     * @param model
     * @return
     */
    @RequestMapping(value = "toCourse", method = RequestMethod.GET)
    public String toCourse(Integer cId, String weixinId, Model model) {
        model.addAttribute("weixinId", weixinId);
        // 查cId的课程信息，以及子课程的信息（分开存放）
        List<Course> subCourseList = courseService.getSubCourseListByCid(cId);
        Course parentCourse = courseService.getCourseByCid(cId);
        model.addAttribute("subCourseList", subCourseList);
        model.addAttribute("parentCourseName", parentCourse.getcName());
        return "front/subcourse_list";
    }

    /**
     * 下载课件
     *
     * @param fId
     */
    @RequestMapping(value = "downLoadFile", method = RequestMethod.GET)
    public void downFile(Integer cId, Integer fId, HttpServletResponse response) {
        // 将cId课程的下载量加1
        Course course = courseService.getCourseByCid(cId);
        course.setDownloadNum(course.getDownloadNum()+1);
        courseService.update(course);

        com.shirokumacafe.archetype.entity.File exitFile = fileService.getFileById(fId);
        String realPath = exitFile.getfAddr() + exitFile.getfName();
        File file = new File(realPath);

        BufferedInputStream br = null;
        OutputStream out = null;
        try {
            if (!file.exists()) {
                response.sendError(404, "File not found!");
                return;
            }
            response.reset();
            response.setContentType("application/x-msdownload");
            response.setHeader("Content-Disposition","attachment; filename=" + new String(exitFile.getfName().getBytes(),"ISO-8859-1"));
            byte[] buf = new byte[1024];
            int len = 0;
            br = null;
            out = null;
            br = new BufferedInputStream(new FileInputStream(file));
            out = response.getOutputStream();
            while ((len = br.read(buf)) > 0) {
                out.write(buf, 0, len);
            }
            out.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            if (br != null) {
                try {
                    br.close();
                    br = null;
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            if (out != null) {
                try {
                    out.close();
                    out = null;
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }

    /**
     * 子课程详情
     *
     * @param cId
     * @param weixinId
     * @param model
     * @return
     */
    @RequestMapping(value = "lookOver", method = RequestMethod.GET)
    public String lookOver(Integer cId, String weixinId, Model model) {
        model.addAttribute("weixinId", weixinId);
        model.addAttribute("course", courseService.getCourseAndImageByCId(cId));
        model.addAttribute("messageList", Responses.writeJson(messageService.findDiscussMessage(cId)));
        return "front/course_details";
    }

    /**
     * 获取讨论列表 异步刷新讨论信息
     *
     * @param cId
     * @return
     */
    @RequestMapping(value = "getMessage", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public String getMessage(Integer cId) {
        return Responses.writeJson(messageService.findDiscussMessage(cId));
    }

    /**
     * 提交回复
     *
     * @param message
     * @param weixinId
     * @return
     */
    @RequestMapping(value = "submitReply", method = RequestMethod.POST)
    @ResponseBody
    public String submitReply(Message message, String weixinId) {
        return Responses.writeJson(messageService.addMessage(message, weixinId));
    }


}