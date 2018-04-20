package com.shirokumacafe.archetype.common.filter;

import com.shirokumacafe.archetype.common.Users;
import com.shirokumacafe.archetype.entity.Student;
import com.shirokumacafe.archetype.entity.User;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 前端登录拦截
 *
 * @since 2018/4/10
 */
public class FrontLoginInterceptor implements HandlerInterceptor {

    /**
     * Handler执行完成之后调用这个方法
     */
    @Override
    public void afterCompletion(HttpServletRequest request,
                                HttpServletResponse response, Object handler, Exception exc)
            throws Exception {

    }

    /**
     * Handler执行之后，ModelAndView返回之前调用这个方法
     */
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response,
                           Object handler, ModelAndView modelAndView) throws Exception {
    }

    /**
     * Handler执行之前调用这个方法
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
                             Object handler) throws Exception {
        //获取请求的URL
        String url = request.getRequestURI();
        if (url.indexOf("front/login") >= 0 || url.indexOf("front/logout") >= 0 || url.indexOf("front/toLogin") >= 0) {
                return true;
        }
        //获取Session
        HttpSession session = request.getSession();
        Student sessionStudent = (Student) session.getAttribute(Users.SESSION_STUDENT);

        if (sessionStudent != null) {
            return true;
        }
        //不符合条件的，跳转到登录界面
        response.sendRedirect("toLogin");
        return false;
    }

}
