package com.shirokumacafe.archetype.service;


import com.shirokumacafe.archetype.common.Configs;
import com.shirokumacafe.archetype.common.Users;
import com.shirokumacafe.archetype.common.exception.ServiceException;
import com.shirokumacafe.archetype.common.mybatis.Page;
import com.shirokumacafe.archetype.common.utilities.DateTimes;
import com.shirokumacafe.archetype.common.utilities.Responses;
import com.shirokumacafe.archetype.entity.User;
import com.shirokumacafe.archetype.entity.UserExample;
import com.shirokumacafe.archetype.entity.ViewUser;
import com.shirokumacafe.archetype.entity.ViewUserExample;
import com.shirokumacafe.archetype.repository.UserMapper;
import com.shirokumacafe.archetype.repository.ViewUserMapper;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 用户管理Service
 *
 * @author Lim
 */
@Component
@Transactional
public class UserService {

    private static Logger logger = LoggerFactory.getLogger(UserService.class);

    @Autowired
    private UserMapper userMapper;
    @Autowired
    private ViewUserMapper viewUserMapper;
    @Autowired
    private Users sessionUsers;

    public Map checkLogin(String username, String password) {
        ViewUserExample example = new ViewUserExample();
        ViewUserExample.Criteria criteria = example.createCriteria();
        criteria.andLoginNameEqualTo(username);
        List<ViewUser> users = viewUserMapper.selectByExample(example);
        if (users == null || users.isEmpty()) {
            return Responses.writeFailAndMsg("用户名不存在.");
        }
        ViewUser user = users.get(0);
        if (!user.getPassword().equals(password)) {
            return Responses.writeFailAndMsg("用户名/密码错误.");
        }
        User sessionUser = new User();
        sessionUser.setLoginName(user.getLoginName());
        sessionUser.setUserId(user.getUserId());
        sessionUser.setUserRole(user.getUserRole());
        sessionUser.setNickName(user.getNickName());
        sessionUser.setCreateId(user.getCreateId());
        sessionUsers.setUser(sessionUser);
        return Responses.writeSuccess();
    }

    public Page<ViewUser> findUserForPage(User user, Page page, Date startDate, Date endDate) {
        ViewUserExample example = new ViewUserExample();
        ViewUserExample.Criteria criteria = example.createCriteria();
        if (sessionUsers.getCurrentUser().getUserId() != Configs.ADMIN_ID) {
            criteria.andUserIdNotEqualTo(Configs.ADMIN_ID);
        }
        if (null != user.getState()) {
            criteria.andStateEqualTo(user.getState());
        }
        if (StringUtils.isNotBlank(user.getLoginName())) {
            criteria.andLoginNameLike("%" + user.getLoginName() + "%");
        }
        if (StringUtils.isNotBlank(user.getNickName())) {
            criteria.andNickNameLike("%" + user.getNickName() + "%");
        }
        if (null != user.getUserRole()) {
            criteria.andUserRoleEqualTo(user.getUserRole());
        }
        if (null != startDate) {
            criteria.andCreateTimeGreaterThanOrEqualTo(startDate);
        }
        if (null != endDate) {
            criteria.andCreateTimeLessThanOrEqualTo(DateTimes.addDate(endDate, 1));
        }
        List<ViewUser> rows = viewUserMapper.selectByExampleWithRowbounds(example, page.createRowBounds());
        Integer results = viewUserMapper.countByExample(example);
        page.setRows(rows);
        page.setResults(results);

        return page;
    }

    public User findUserByLoginName(String loginName) {
        UserExample example = new UserExample();
        UserExample.Criteria criteria = example.createCriteria();
        criteria.andLoginNameEqualTo(loginName);
        User user = null;
        try {
            user = userMapper.selectByExample(example).get(0);
        } catch (Exception e) {
            //忽略
        }
        return user;
    }

    public ViewUser findViewUserByLoginName(String loginName) {
        ViewUserExample example = new ViewUserExample();
        ViewUserExample.Criteria criteria = example.createCriteria();
        criteria.andLoginNameEqualTo(loginName);
        ViewUser user = null;
        try {
            user = viewUserMapper.selectByExample(example).get(0);
        } catch (Exception e) {
            //忽略
        }
        return user;
    }


    public Map add(User user) {
        Map map = new HashMap();
        UserExample example = new UserExample();
        UserExample.Criteria criteria = example.createCriteria();
        criteria.andLoginNameEqualTo(user.getLoginName());
        List<User> users = userMapper.selectByExample(example);
        if (users.size() > 0) {
            map.put("msg", "该用户名已注册，请重新选择用户名");
            return map;
        }
        user.setCreateId(sessionUsers.getCurrentUser().getUserId());
        user.setCreateTime(new Date());
        if (null == user.getPassword()) {
            user.setPassword(Configs.DEFAULT_PASSWORD);
        }
        if (null == user.getState()) {
            user.setState(1);
        }
        userMapper.insertSelective(user);
        return Responses.writeSuccess();
    }

    public Map update(User user) {
        UserExample example = new UserExample();
        UserExample.Criteria criteria = example.createCriteria();
        criteria.andLoginNameEqualTo(user.getLoginName());

        List<User> users = userMapper.selectByExample(example);
        if (users.size() > 0) {
            if (!users.get(0).getUserId().equals(user.getUserId())) {
                return Responses.writeFailAndMsg("该账号已存在");
            }
        }
        userMapper.updateByPrimaryKeySelective(user);
        return Responses.writeSuccess();
    }

    public void delete(List<Integer> ids) {

        if (isSupervisor(ids)) {
            logger.warn("操作员{}尝试删除超级管理员用户", sessionUsers.getCurrentUser().getLoginName());
            throw new ServiceException("不能删除超级管理员用户");
        }

        UserExample example = new UserExample();
        UserExample.Criteria criteria = example.createCriteria();
        criteria.andUserIdIn(ids);
        userMapper.deleteByExample(example);
    }

    /**
     * 更改密码
     *
     * @param oldPass
     * @param newPass
     */
    public void chancePassword(String oldPass, String newPass) {
        User dbUser = userMapper.selectByPrimaryKey(sessionUsers.getCurrentUser().getUserId());
        String dbPassword = dbUser.getPassword();
        if (dbPassword.equals(oldPass)) {
            dbUser.setPassword(newPass);
            userMapper.updateByPrimaryKeySelective(dbUser);
        } else {
            throw new ServiceException("旧密码不正确!");
        }
    }

    /**
     * 重置密码
     */
    public void resetPassword(Integer userId) {
        User user = new User();
        user.setUserId(userId);
        user.setPassword(Configs.DEFAULT_PASSWORD);
        userMapper.updateByPrimaryKeySelective(user);
    }

    /**
     * 批量重置密码
     */
    public void resetPassword(List<Integer> ids) {
        User user = new User();
        user.setPassword(Configs.DEFAULT_PASSWORD);
        UserExample example = new UserExample();
        UserExample.Criteria criteria = example.createCriteria();
        criteria.andUserIdIn(ids);
        userMapper.updateByExampleSelective(user, example);
    }

    /**
     * 判断是否超级管理员.
     */
    private boolean isSupervisor(List<Integer> ids) {
        return ids.contains(Configs.ADMIN_ID);
    }

    /**
     * 判断是否超级管理员.
     */
    private boolean isSupervisor(Integer id) {
        return Configs.ADMIN_ID == id;
    }

    /**
     * 判断当前用户是否是超级管理员，提供给外部调用
     *
     * @return boolean
     */
    public boolean isSuper() {
        if (sessionUsers.getCurrentUser().getUserId() == Configs.ADMIN_ID) {
            return true;
        }
        return false;
    }

    /**
     * 改变用户状态
     *
     * @param user
     */
    public void changeState(User user) {
        Integer state = user.getState();
        if (state == 0) {
            state = 1;
        } else {
            state = 0;
        }
        user.setState(state);
        userMapper.updateByPrimaryKeySelective(user);
    }

    /**
     * 根据角色ID查找用户
     *
     * @param roleId
     * @return
     */
    public List<User> getUsersByRoleId(Integer roleId) {
        UserExample example = new UserExample();
        UserExample.Criteria criteria = example.createCriteria();
        criteria.andUserRoleEqualTo(roleId);
        return userMapper.selectByExample(example);
    }


}
