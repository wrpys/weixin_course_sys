package com.shirokumacafe.archetype.web;

import com.shirokumacafe.archetype.common.Users;
import com.shirokumacafe.archetype.entity.User;
import com.shirokumacafe.archetype.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * 登录
 */
@Controller
@RequestMapping(value = "/login")
public class LoginController {

	@Autowired
	private UserService userService;

	@RequestMapping(method = RequestMethod.GET)
	public String to_login() {
		return "login";
	}

	@RequestMapping(method = RequestMethod.POST)
	public String login(String username, String password, Model model) {
		Map result = userService.checkLogin(username, password);
		boolean isSucess = Boolean.valueOf(String.valueOf(result.get("success")));
		if (isSucess) {
			return "redirect:center";
		} else {
			model.addAttribute("msg", result.get("msg"));
			return "login";
		}
	}

}
