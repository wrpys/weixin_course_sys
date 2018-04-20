package com.shirokumacafe.archetype.web;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.github.pagehelper.PageHelper;
import com.shirokumacafe.archetype.common.Configs;
import com.shirokumacafe.archetype.common.mybatis.Page;
import com.shirokumacafe.archetype.common.utilities.Responses;
import com.shirokumacafe.archetype.entity.Clzss;
import com.shirokumacafe.archetype.entity.User;
import com.shirokumacafe.archetype.service.ClzssService;
import com.shirokumacafe.archetype.service.UserService;
/**
 * 班级管理
 * @author CZX
 *
 */
@Controller
@RequestMapping("/clzss")
public class ClzssController {

    @Autowired
    private ClzssService clzssService;
    
    @Autowired
    private UserService userService;
    
    @RequestMapping
    public String to(Model model){
    	List<User> users = userService.getUsersByRoleId(Configs.CUSTOMER_TEACHER);
    	users.addAll(userService.getUsersByRoleId(Configs.CUSTOMER_AMIN));
        model.addAttribute("users",users);
        return "clzss";
    }
    
    @RequestMapping(value = "list", method = RequestMethod.GET)
    @ResponseBody
    public Page<Clzss> list(Clzss clzss,Page<Clzss> page) {
    	com.github.pagehelper.Page<?> pageHelper = PageHelper.startPage(page.getPageIndex(), page.getLimit());
    	List<Clzss> clzssList = clzssService.findAll();
    	page.setRows(clzssList);
        page.setResults((int)pageHelper.getTotal());
        return page;
    }
    
    

    @RequestMapping(value = "add", method = RequestMethod.POST)
    @ResponseBody
    public Map<?, ?> add(Clzss clzss) {
        clzssService.add(clzss);
        return Responses.writeSuccess();
    }

    @RequestMapping(value = "update", method = RequestMethod.POST)
    @ResponseBody
    public Map<?, ?> update(Clzss clzss) {
        clzssService.update(clzss);
        return Responses.writeSuccess();
    }
    
    
    @RequestMapping(value = "deleteBatchs", method = RequestMethod.POST)
    @ResponseBody
    public Map<?, ?> delete(@RequestParam(value = "ids") List<Integer> ids) {
        clzssService.delete(ids);
        return Responses.writeSuccess();
    }

}
