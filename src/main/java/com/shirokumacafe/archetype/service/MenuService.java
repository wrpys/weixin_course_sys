package com.shirokumacafe.archetype.service;

import com.shirokumacafe.archetype.common.Users;
import com.shirokumacafe.archetype.common.utilities.Responses;
import com.shirokumacafe.archetype.entity.Menu;
import com.shirokumacafe.archetype.entity.MenuExample;
import com.shirokumacafe.archetype.entity.RolePermission;
import com.shirokumacafe.archetype.repository.MenuMapper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 菜单管理Service
 *
 * @author wrp
 */
@Component
@Transactional
public class MenuService {
    @Autowired
    private MenuMapper menuMapper;
    @Autowired
    private RoleService roleService;
    @Autowired
    private Users sessionUsers;

    /**
     * 获取所有按钮
     */
    public List<Menu> findAllMenu() {
        MenuExample example = new MenuExample();
        example.setOrderByClause("sort asc");
        List<Menu> menus = menuMapper.selectByExample(example);
        return menus;
    }

    /**
     * 添加菜单
     *
     * @param menu
     */
    public void add(Menu menu) {
        menu.setState(1);
        menuMapper.insert(menu);
    }

    /**
     * 修改菜单
     *
     * @param menu
     * @return
     */
    public Menu update(Menu menu) {
        MenuExample example = new MenuExample();
        MenuExample.Criteria criteria = example.createCriteria();
        criteria.andMenuCodeEqualTo(menu.getMenuCode());
        List<Menu> menuList = menuMapper.selectByExample(example);
//        Menu menuOld = menuMapper.selectByPrimaryKey(menu.getMenuId());
//        if (!menu.getMenuName().equals(menuOld.getMenuName())){
//            RolePermissionExample rolePermissionExample = new RolePermissionExample();
//            RolePermissionExample.Criteria rolePermissionCriteria = rolePermissionExample.createCriteria();
//            rolePermissionCriteria.andPermissionEqualTo(menuOld.getMenuName());
//            List<RolePermission> rolePermissions = rolePermissionMapper.selectByExample(rolePermissionExample);
//            if (rolePermissions!=null&&rolePermissions.size()>0){
//                for (RolePermission rolePermission : rolePermissions){
//
//                }
//            }
//        }
        if (menuList.size() > 0) {
            if (!menu.getMenuId().equals(menuList.get(0).getMenuId())) {
                menu.setMenuCode(menu.getMenuCode() + "Copy");
            }
        }
        menuMapper.updateByPrimaryKeySelective(menu);
        return menu;
    }

    /**
     * 批量删除菜单
     *
     * @param ids
     * @return
     */
    public Map delete(List<Integer> ids) {

        MenuExample example = new MenuExample();
        MenuExample.Criteria criteria = example.createCriteria();
        criteria.andMenuIdIn(ids);

        List<Menu> menuList = menuMapper.selectByExample(example);
        MenuExample menuExample = new MenuExample();
        MenuExample.Criteria menuCriteria;
        for (Menu menu : menuList) {
            if (menu.getMenuPid() == 0) {
                menuCriteria = menuExample.createCriteria();
                menuCriteria.andMenuPidEqualTo(menu.getMenuId());
                if (menuMapper.selectByExample(menuExample).size() > 0) {
                    return Responses.writeFailAndMsg("该菜单下包含子菜单,请先修改或删除子菜单");
                }
            }
        }

        menuMapper.deleteByExample(example);
        return Responses.writeSuccess();
    }


    /**
     * 构建Accordion式菜单(权限过滤)
     *
     * @return
     */
    public List<Map> buildMenu() {
        List<RolePermission> permissions = roleService.findPermissionByRoleId(sessionUsers.getCurrentUser().getUserRole());
        List<String> codes = new ArrayList<String>();
        for (RolePermission item : permissions) {
            String menuCode = StringUtils.split(item.getPermission(), ":")[0];
            codes.add(menuCode);
        }
        MenuExample rootExample = new MenuExample();
        MenuExample.Criteria rootCriteria = rootExample.createCriteria();
        rootCriteria.andMenuPidEqualTo(0);
        rootCriteria.andMenuCodeIn(codes);
        rootExample.setOrderByClause("sort");
        List<Menu> rootMenus = menuMapper.selectByExample(rootExample);
        List<Map> buildList = new ArrayList<Map>();
        for (Menu menu : rootMenus) {
            List<Menu> list = new ArrayList<Menu>();
            recur(menu.getMenuId(), list, codes);
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("menuId", menu.getMenuId());
            map.put("menuName", menu.getMenuName());
            map.put("children", list);
            buildList.add(map);
        }
        return buildList;
    }

    /**
     * 内部递归
     *
     * @param pid
     * @param list
     */
    private void recur(Integer pid, List<Menu> list, List<String> codes) {
        MenuExample rootExample = new MenuExample();
        MenuExample.Criteria rootCriteria = rootExample.createCriteria();
        rootCriteria.andMenuPidEqualTo(pid);

        if (null != codes && !codes.isEmpty()) {
            rootCriteria.andMenuCodeIn(codes);
        }

        rootExample.setOrderByClause("sort");
        List<Menu> rootMenus = menuMapper.selectByExample(rootExample);
        //如果没有子节点则返回到被调用点
        if (rootMenus.isEmpty()) {
            return;
        }
        for (Menu menu : rootMenus) {
            list.add(menu);
            recur(menu.getMenuId(), list, codes);
        }
    }
}
