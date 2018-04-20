package com.shirokumacafe.archetype.web;

import com.shirokumacafe.archetype.common.utilities.Responses;
import com.shirokumacafe.archetype.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 主界面 根据角色构建菜单
 *
 * @author wrp
 */
@Controller
public class CenterController {

    @Autowired
    private MenuService menuService;

    @RequestMapping(value = "/center")
    public String to(Model model) {
        model.addAttribute("menus", Responses.writeJson(menuService.buildMenu()));
        return "center";
    }

    @RequestMapping(value = "/toIndex")
    public String toIndex(Model model) {
        return "index";
    }

}
