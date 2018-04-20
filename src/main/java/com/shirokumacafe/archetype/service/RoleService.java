package com.shirokumacafe.archetype.service;

import com.shirokumacafe.archetype.common.Users;
import com.shirokumacafe.archetype.common.mybatis.Page;
import com.shirokumacafe.archetype.common.utilities.Responses;
import com.shirokumacafe.archetype.entity.Role;
import com.shirokumacafe.archetype.entity.RoleExample;
import com.shirokumacafe.archetype.entity.RolePermission;
import com.shirokumacafe.archetype.entity.RolePermissionExample;
import com.shirokumacafe.archetype.entity.ViewRole;
import com.shirokumacafe.archetype.repository.RoleMapper;
import com.shirokumacafe.archetype.repository.RolePermissionMapper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 角色管理Service
 *
 * @author wrp
 */
@Component
@Transactional
public class RoleService {
    @Autowired
    private RoleMapper roleMapper;
    @Autowired
    private RolePermissionMapper permissionMapper;
    @Autowired
    private Users sessionUsers;

    public Page<ViewRole> findRoleForPage(Role role, Page page) {
        RoleExample example = new RoleExample();
        RoleExample.Criteria criteria = example.createCriteria();

        if (StringUtils.isNotBlank(role.getRoleName())) {
            criteria.andRoleNameLike("%" + role.getRoleName() + "%");
        }
        if (null != role.getState()) {
            criteria.andStateEqualTo(role.getState());
        }

        List<Role> rows = roleMapper.selectByExampleWithRowbounds(example, page.createRowBounds());
        Integer total = roleMapper.countByExample(null);
        List<ViewRole> viewRoles = new ArrayList<ViewRole>();
        for (Role roleTemp : rows) {
            ViewRole viewRole = new ViewRole();
            viewRole.setRoleId(roleTemp.getRoleId());
            viewRole.setRoleCode(roleTemp.getRoleCode());
            viewRole.setRoleName(roleTemp.getRoleName());
            viewRole.setSys(roleTemp.getSys());
            viewRole.setRemark(roleTemp.getRemark());
            viewRole.setState(roleTemp.getState());
            viewRole.setCreateId(roleTemp.getCreateId());
            viewRole.setCreateTime(roleTemp.getCreateTime());
            viewRole.setUpdateId(roleTemp.getUpdateId());
            viewRole.setUpdateTime(roleTemp.getUpdateTime());

            RolePermissionExample rolePermissionExample = new RolePermissionExample();
            RolePermissionExample.Criteria rolePermissionCriteria = rolePermissionExample.createCriteria();
            rolePermissionCriteria.andRoleIdEqualTo(roleTemp.getRoleId());
            List<RolePermission> rolePermissionList = permissionMapper.selectByExample(rolePermissionExample);
            String permissions = "";
            if (rolePermissionList.size() > 0) {
                for (int i = 0, len = rolePermissionList.size(); i < len; i++) {
                    permissions += rolePermissionList.get(i).getPermission();
                    if (i < len - 1) {
                        permissions += ",";
                    }
                }
                viewRole.setPermission(permissions);
            }
            viewRoles.add(viewRole);
        }
        page.setRows(viewRoles);
        page.setResults(total);
        return page;
    }

    public List<Role> findRoleForList() {
        RoleExample example = new RoleExample();
        RoleExample.Criteria criteria = example.createCriteria();
        criteria.andStateEqualTo(1);
        List<Role> roles = roleMapper.selectByExample(example);
        return roles;
    }

    public Map add(Role role, String buttons) {
        role.setCreateId(sessionUsers.getCurrentUser().getUserId());
        role.setCreateTime(new Date());

        RoleExample example = new RoleExample();
        RoleExample.Criteria criteria = example.createCriteria();
        criteria.andRoleNameEqualTo(role.getRoleName());
        List<Role> roleList = roleMapper.selectByExample(example);
        if (roleList.size() > 0) {
            return Responses.writeFailAndMsg("该角色名已存在！");
        }
        RoleExample roleExample = new RoleExample();
        RoleExample.Criteria roleCriteria = roleExample.createCriteria();
        roleCriteria.andRoleCodeEqualTo(role.getRoleCode());
        List<Role> roles = roleMapper.selectByExample(roleExample);
        if (roles.size() > 0) {
            return Responses.writeFailAndMsg("改角色代码已存在！");
        }
        roleMapper.insert(role);
        addPermission(role, buttons);
        return Responses.writeSuccess();
    }

    private void addPermission(Role role, String buttons) {
        String[] buttonArr = StringUtils.split(buttons, ",");
        for (String button : buttonArr) {
            RolePermission permission = new RolePermission();
            permission.setRoleId(role.getRoleId());
            permission.setPermission(button);
            permissionMapper.insert(permission);
        }
    }

    public Map update(Role role, String buttons) {
        role.setUpdateId(sessionUsers.getCurrentUser().getUserId());
        role.setUpdateTime(new Date());
        //超级管理员不能修改
//        if (role.getRoleId().equals(Configs.CUSTOMER_MANAGEID)){
//            return  Responses.writeFailAndMsg("超级管理员角色无法修改");
//        }else if (role.getRoleId().equals(Configs.CUSTOMER_ROLEID)){
//            return Responses.writeFailAndMsg("用户角色无法修改");
//        }else if (role.getRoleId().equals(Configs.CUSTOMER_DEALERID)){
//            return Responses.writeFailAndMsg("经销商角色无法修改");
//        }

        RoleExample example = new RoleExample();
        RoleExample.Criteria criteria = example.createCriteria();
        criteria.andRoleNameEqualTo(role.getRoleName());
        List<Role> roleList = roleMapper.selectByExample(example);
        if (roleList.size() > 0) {
            if (!roleList.get(0).getRoleId().equals(role.getRoleId())) {
                return Responses.writeFailAndMsg("该角色名已存在！");
            }
        }
        RoleExample roleExample = new RoleExample();
        RoleExample.Criteria roleCriteria = roleExample.createCriteria();
        roleCriteria.andRoleCodeEqualTo(role.getRoleCode());
        List<Role> roles = roleMapper.selectByExample(roleExample);
        if (roles.size() > 0) {
            if (!roles.get(0).getRoleId().equals(role.getRoleId())) {
                return Responses.writeFailAndMsg("改角色代码已存在！");
            }
        }

        roleMapper.updateByPrimaryKeySelective(role);

        deletePermission(role);
        addPermission(role, buttons);
        return Responses.writeSuccess();

    }

    private void deletePermission(Role role) {
        RolePermissionExample example = new RolePermissionExample();
        example.createCriteria().andRoleIdEqualTo(role.getRoleId());
        permissionMapper.deleteByExample(example);
    }

    public Map delete(List<Integer> ids) {
        RoleExample example = new RoleExample();
        RoleExample.Criteria criteria = example.createCriteria();
        criteria.andRoleIdIn(ids);

        roleMapper.deleteByExample(example);

        RolePermissionExample permissionExample = new RolePermissionExample();
        permissionExample.createCriteria().andRoleIdIn(ids);

        permissionMapper.deleteByExample(permissionExample);
        return Responses.writeSuccess();
    }


    public List<RolePermission> findPermissionByRoleId(Integer id) {
        RolePermissionExample example = new RolePermissionExample();
        RolePermissionExample.Criteria criteria = example.createCriteria();
        criteria.andRoleIdEqualTo(id);
        return permissionMapper.selectByExample(example);
    }

    public Role getRoleByRoleId(Integer roleId) {
        return roleMapper.selectByPrimaryKey(roleId);
    }

}
