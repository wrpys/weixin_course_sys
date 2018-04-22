package com.shirokumacafe.archetype.service;

import com.shirokumacafe.archetype.entity.Student;
import com.shirokumacafe.archetype.entity.ViewUser;
import com.shirokumacafe.archetype.entity.ViewUserExample;
import com.shirokumacafe.archetype.model.WeixinUserInfo;
import com.shirokumacafe.archetype.repository.StudentMapper;
import com.shirokumacafe.archetype.repository.ViewUserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 前台service
 *
 * @author wrp
 * @since 2018/4/22
 */
@Service
public class FrontService {

    @Autowired
    private StudentMapper studentMapper;
    @Autowired
    private ViewUserMapper viewUserMapper;

    /**
     * 根据微信ID获取对应的用户信息
     *
     * @param weixinId
     * @return
     */
    public WeixinUserInfo getWeixinUserInfo(String weixinId) {
        // 先查看该微信号是否是教师
        ViewUserExample example1 = new ViewUserExample();
        ViewUserExample.Criteria criteria1 = example1.createCriteria();
        criteria1.andWeixinIdEqualTo(weixinId);
        List<ViewUser> users = viewUserMapper.selectByExample(example1);
        // 是教师
        if (users != null && !users.isEmpty()) {
            ViewUser user = users.get(0);
            return buildWeixinUserInfo(weixinId, 2, user.getUserId(), user.getLoginName(), user.getNickName(), user.getPassword());
        }
        // 不是教师，就查看是否是学生
        else {
            Student params = new Student();
            params.setWeixinId(weixinId);
            List<Student> students = studentMapper.selectByParams(params);
            // 是学生
            if (students != null && !students.isEmpty()) {
                Student student = students.get(0);
                return buildWeixinUserInfo(weixinId, 1, student.getsId(), student.getsNo(), student.getsName(), student.getsPassword());
            }
            // 不是学生 进行绑定提示
            else {
                return null;
            }
        }
    }

    /**
     * 构造微信用户信息
     * @param weixinId
     * @param role
     * @param userId
     * @param account
     * @param userName
     * @param password
     * @return
     */
    private WeixinUserInfo buildWeixinUserInfo(String weixinId, Integer role, Integer userId,
                                               String account, String userName, String password) {
        WeixinUserInfo weixinUserInfo = new WeixinUserInfo();
        weixinUserInfo.setWeixinId(weixinId);
        weixinUserInfo.setRole(role);
        weixinUserInfo.setUserId(userId);
        weixinUserInfo.setAccount(account);
        weixinUserInfo.setUserName(userName);
        weixinUserInfo.setPassword(password);
        return weixinUserInfo;
    }

}
