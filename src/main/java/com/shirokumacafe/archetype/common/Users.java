package com.shirokumacafe.archetype.common;

import com.shirokumacafe.archetype.entity.Student;
import com.shirokumacafe.archetype.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpSession;

/**
 * 保存登录用户
 */
@Component
public class Users {

    public static final String SESSION_USER = "user_info";
    public static final String SESSION_STUDENT = "student_info";

    @Autowired
    private HttpSession session;

    public User getCurrentUser() {
        return (User) session.getAttribute(SESSION_USER);
    }

    public void setUser(User user) {
        session.setAttribute(SESSION_USER, user);
    }

    public void removeUser() {
        session.removeAttribute(SESSION_USER);
    }

    public Student getStudent() {
        return (Student) session.getAttribute(SESSION_STUDENT);
    }

    public void setStudent(Student student) {
        session.setAttribute(SESSION_STUDENT, student);
    }

    public void removeStudent() {
        session.removeAttribute(SESSION_STUDENT);
    }

}
