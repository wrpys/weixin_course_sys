package com.shirokumacafe.archetype.web;
import com.shirokumacafe.archetype.common.mybatis.Page;
import com.shirokumacafe.archetype.common.utilities.Responses;
import com.shirokumacafe.archetype.entity.Role;
import com.shirokumacafe.archetype.entity.ViewRole;
import com.shirokumacafe.archetype.service.MenuService;
import com.shirokumacafe.archetype.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

/**
* 角色管理
*
* @author wrp
*/
@Controller
@RequestMapping(value = "/role")
public class RoleController {
    @Autowired
    private RoleService roleService;
    @Autowired
    private MenuService menuService;

    @RequestMapping
    public String to(Model model) {
        model.addAttribute("menus", Responses.writeJson(menuService.findAllMenu()));
        return "role";
    }

    @RequestMapping(value = "list", method = RequestMethod.GET)
    @ResponseBody
    public String list(Role role, Page page) {
        Page<ViewRole> roles = roleService.findRoleForPage(role, page);
        return Responses.writeJson(roles);

    }

    @RequestMapping(value = "add", method = RequestMethod.POST)
    @ResponseBody
    public Map add(Role role, String buttons) {
        Map map=roleService.add(role, buttons);
        return map;
    }

    @RequestMapping(value = "update", method = RequestMethod.POST)
    @ResponseBody
    public Map update(Role role,String buttons) {
        Map map = roleService.update(role, buttons);
        return map;
    }

    @RequestMapping(value = "delete", method = RequestMethod.POST)
    @ResponseBody
    public Map delete(@RequestParam(value = "ids") List<Integer> ids) {
        return roleService.delete(ids);
    }
}
