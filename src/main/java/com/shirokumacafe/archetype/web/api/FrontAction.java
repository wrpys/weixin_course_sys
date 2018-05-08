package com.shirokumacafe.archetype.web.api;

import com.shirokumacafe.archetype.common.utilities.Responses;
import com.shirokumacafe.archetype.entity.Course;
import com.shirokumacafe.archetype.entity.Message;
import com.shirokumacafe.archetype.model.WeixinUserInfo;
import com.shirokumacafe.archetype.service.CourseService;
import com.shirokumacafe.archetype.service.FileService;
import com.shirokumacafe.archetype.service.FrontService;
import com.shirokumacafe.archetype.service.MessageService;
import com.shirokumacafe.archetype.service.StudentService;
import com.shirokumacafe.archetype.service.UserService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 前台入口
 */
@Controller
@RequestMapping(value = "/front")
public class FrontAction {

    private Map<String, Long> session = new HashMap<>();

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
    @Autowired
    private FrontService frontService;

    /**
     * 跳转到绑定页面
     */
    @RequestMapping(value = "toBinding", method = RequestMethod.GET)
    public String toBinding(String weixinId, Model model) {
        WeixinUserInfo weixinUserInfo = frontService.getWeixinUserInfo(weixinId);
        if (weixinUserInfo == null) {
            model.addAttribute("weixinId", weixinId);
            return "front/binding";
        } else {
            return "redirect:myInfo?weixinId=" + weixinId;
        }
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
        WeixinUserInfo weixinUserInfo = frontService.getWeixinUserInfo(weixinId);
        if (weixinUserInfo != null) {
            return "redirect:myInfo?weixinId=" + weixinId;
        }
        Map result = null;
        if (operRole.intValue() == 1) {
            result = studentService.binding(weixinId, account);
        } else if (operRole.intValue() == 2) {
            result = userService.binding(weixinId, account);
        }
        boolean isSucess = Boolean.valueOf(String.valueOf(result.get("success")));
        if (isSucess) {
            return "redirect:myInfo?weixinId=" + weixinId;
        } else {
            model.addAttribute("weixinId", weixinId);
            model.addAttribute("msg", result.get("msg"));
            return "front/binding";
        }
    }

    /**
     * 个人信息
     * @param weixinId 微信ID
     * @param model
     * @return
     */
    @RequestMapping(value = "myInfo", method = RequestMethod.GET)
    public String myInfo(String weixinId, Model model) {
        WeixinUserInfo weixinUserInfo = frontService.getWeixinUserInfo(weixinId);
        if (weixinUserInfo == null) {
            return "redirect:toBinding?weixinId=" + weixinId;
        }
        if (StringUtils.isEmpty(weixinUserInfo.getChatHeadAddr())) {
            if (2 == weixinUserInfo.getRole()) {
                weixinUserInfo.setChatHeadAddr("/static/front/images/icons/tea.png");
            } else {
                weixinUserInfo.setChatHeadAddr("/static/front/images/icons/stu.png");
            }
        }
        model.addAttribute("myInfo", weixinUserInfo);
        model.addAttribute("messages", messageService.getMyInfoMessage(weixinUserInfo));
        return "front/my_info";
    }

    /**
     * 上传头像
     */
    @RequestMapping(value = "uploadFile")
    public String uploadFile(@RequestParam("chatHeadAddr") CommonsMultipartFile file, HttpServletRequest request, Model model) throws Exception {
        String filename = file.getOriginalFilename();
        String subName[] = filename.split("\\.");
        String path = request.getServletContext().getRealPath("/file/");
        File fileTmp = new File(path);
        if(!fileTmp.exists()) {
            fileTmp.mkdir();
        }
        fileTmp = new File(path + "icon/");
        if(!fileTmp.exists()) {
            fileTmp.mkdir();
        }
        String icon = "icon/" + request.getParameter("account") + "_" + System.currentTimeMillis() + "." + subName[1];
        file.transferTo(new File(path + icon));

        Integer r = Integer.valueOf(request.getParameter("role"));
        Integer id = Integer.valueOf(request.getParameter("userId"));
        icon = "/file/" + icon;
        frontService.updateIcon(r, id, icon);
        return "redirect:myInfo?weixinId=" + request.getParameter("weixinId");
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
        WeixinUserInfo weixinUserInfo = frontService.getWeixinUserInfo(weixinId);
        if (weixinUserInfo == null) {
            return "redirect:toBinding?weixinId=" + weixinId;
        }
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
    public void downFile(Integer cId, Integer fId, String weixinId, HttpServletResponse response) {
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
            response.setHeader("Content-Disposition", "attachment; filename=" + new String(exitFile.getfName().getBytes(), "ISO-8859-1"));
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
            Long firstDate = session.get("weixinId");
            if (firstDate == null || (firstDate != null && (System.currentTimeMillis() - firstDate.longValue()) > 30 * 60 * 1000)) {
                session.put("weixinId", System.currentTimeMillis());
                Course course = courseService.getCourseByCid(cId);
                course.setDownloadNum(course.getDownloadNum() + 1);
                courseService.update(course);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
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
        WeixinUserInfo weixinUserInfo = frontService.getWeixinUserInfo(weixinId);
        if (weixinUserInfo == null) {
            return "redirect:toBinding?weixinId=" + weixinId;
        }
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