package com.shirokumacafe.archetype.web;

import com.shirokumacafe.archetype.common.Users;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * 登出
 */
@Controller
@RequestMapping(value = "/logout")
public class LogoutController {

    @Autowired
    private Users sessionUsers;

    @RequestMapping(method = RequestMethod.GET)
    public String logout() {
        sessionUsers.removeUser();
        return "redirect:login";
    }


}
