package com.shirokumacafe.archetype.common.filter;

import com.shirokumacafe.archetype.common.Users;
import com.shirokumacafe.archetype.entity.User;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 登录拦截
 *
 * @since 2018/4/4
 */
public class LoginInterceptor implements HandlerInterceptor {

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
        if (url.indexOf("login") >= 0 || url.indexOf("logout") >= 0) {
//            if (request.getMethod().equals("GET")) {
                return true;
//            }
        }
        //获取Session
        HttpSession session = request.getSession();
        User sessionUser = (User) session.getAttribute(Users.SESSION_USER);

        if (sessionUser != null) {
            return true;
        }
        //不符合条件的，跳转到登录界面
        response.sendRedirect("login");
        return false;
    }

}
