package com.shirokumacafe.archetype.web;

import com.shirokumacafe.archetype.common.utilities.Responses;
import com.shirokumacafe.archetype.entity.Menu;
import com.shirokumacafe.archetype.service.MenuService;
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
 * 菜单管理
 * @author wrp
 */
@Controller
@RequestMapping("menu")
public class MenuController {

    @Autowired
    private MenuService menuService;

    @RequestMapping
    public String to(Model model){
        model.addAttribute("menus", Responses.writeJson(menuService.findAllMenu()) );
        return "menu";
    }

    @RequestMapping(value = "add", method = RequestMethod.POST)
    @ResponseBody
    public Map add(Menu menu) {
        menuService.add(menu);
        return Responses.writeSuccess(menu,"menu");
    }

    @RequestMapping(value = "update", method = RequestMethod.POST)
    @ResponseBody
    public Map update(Menu menu) {
        //menu.setMenuLink(null);  //不允许修改地址
        Menu menuTemp = menuService.update(menu);
        return Responses.writeSuccess(menuTemp,"menu");
    }

    @RequestMapping(value = "delete", method = RequestMethod.POST)
    @ResponseBody
    public Map delete(@RequestParam(value = "ids") List<Integer> ids) {
        return menuService.delete(ids);
    }

}
