package com.zhuxiaoxue.controller;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class HomeController {

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String index() {
        return "/login";
    }

    @RequestMapping(value = "/", method = RequestMethod.POST)
    public String login(String username, String password, RedirectAttributes redirectAttributes) {

        Subject subject = SecurityUtils.getSubject();
        if (subject.isAuthenticated()) {
            subject.logout();
        }
        try {
            UsernamePasswordToken usernamePasswordToken = new UsernamePasswordToken(username,password);
            subject.login(usernamePasswordToken);
            return "redirect:/home";
        } catch (AuthenticationException exception) {
            redirectAttributes.addFlashAttribute("message","账号或密码错误");
            return "redirect:/";
        }
    }

    @RequestMapping(value = "/home", method = RequestMethod.GET)
    public String home() {
        return "/home";
    }

    @RequestMapping(value = "/user/logout",method = RequestMethod.GET)
    public String logout(){
        SecurityUtils.getSubject().logout();
        return "redirect:/";
    }
}
