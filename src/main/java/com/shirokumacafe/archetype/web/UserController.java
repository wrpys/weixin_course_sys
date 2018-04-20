
package com.shirokumacafe.archetype.web;


import com.shirokumacafe.archetype.common.mybatis.Page;
import com.shirokumacafe.archetype.common.utilities.Responses;
import com.shirokumacafe.archetype.entity.Role;
import com.shirokumacafe.archetype.entity.User;
import com.shirokumacafe.archetype.entity.ViewUser;
import com.shirokumacafe.archetype.service.RoleService;
import com.shirokumacafe.archetype.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 用户管理
 * @author Lim
 */
@Controller
@RequestMapping(value = "/user")
class UserController {
    @Autowired
    private UserService userService;
    @Autowired
    private RoleService roleService;

    @RequestMapping
    public String to(Model model){
        List<Role> roles = roleService.findRoleForList();
        model.addAttribute("roleList",roles);
        model.addAttribute("roles",Responses.writeJson(roles));
        return "user";
    }

    @RequestMapping(value = "list",method = RequestMethod.GET)
    @ResponseBody
    public String list(User user,Page page,Date startDate,Date endDate){
        Page<ViewUser> users = userService.findUserForPage(user,page,startDate,endDate);
        return Responses.writeJson(users);
    }

    @RequestMapping(value = "add",method = RequestMethod.POST)
    @ResponseBody
    public String add(User user){
        Map map = userService.add(user);
     return Responses.writeJson(map);
    }

    @RequestMapping(value = "update",method = RequestMethod.POST)
    @ResponseBody
    public Map update(User user){
        return userService.update(user);
    }

    @RequestMapping(value = "delete",method = RequestMethod.POST)
    @ResponseBody
    public Map delete(@RequestParam(value = "ids") List<Integer> ids){
        userService.delete(ids);
        return Responses.writeSuccess();
    }

    @RequestMapping(value = "changePassword", method = RequestMethod.POST)
    @ResponseBody
    public Map changePassword(String oldPass,String newPass) {
        userService.chancePassword(oldPass,newPass);
        return Responses.writeSuccess();
    }

    @RequestMapping(value = "resetPassword", method = RequestMethod.POST)
    @ResponseBody
    public Map resetPassword(@RequestParam(value = "ids") List<Integer> ids) {
        userService.resetPassword(ids);
        return Responses.writeSuccess();
    }

    @RequestMapping(value = "changeState", method = RequestMethod.POST)
    @ResponseBody
    public Map changeState(User user) {
        userService.changeState(user);
        return Responses.writeSuccess();
    }
}



