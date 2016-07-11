package com.zhuxiaoxue.controller;

import com.google.common.collect.Maps;
import com.zhuxiaoxue.dto.DataTableReasult;
import com.zhuxiaoxue.dto.JsonResult;
import com.zhuxiaoxue.pojo.User;
import com.zhuxiaoxue.service.UserService;
import com.zhuxiaoxue.util.Strings;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Inject
    private UserService userService;

    @RequestMapping(value = "/users",method = RequestMethod.GET)
    public String userList(Model model){
        model.addAttribute("roleList",userService.findAllRole());
        return "/admin/userList";
    }

    /**
     * 获取员工信息列表
     * @param request
     * @return
     */
    @RequestMapping(value = "/users/load",method = RequestMethod.GET)
    @ResponseBody
    public DataTableReasult<User> loadUsers(HttpServletRequest request){
        String draw = request.getParameter("draw");
        String start = request.getParameter("start");
        String length = request.getParameter("length");
        String username = request.getParameter("search[value]");

        username = Strings.toUTF8(username);
        Map<String,Object> params = Maps.newHashMap();
        params.put("start",start);
        params.put("length",length);
        params.put("username",username);


        List<User> userList = userService.findUserlistByParams(params);

        Long count = userService.findUserCount();
        Long filterCount = userService.findUserCountByParams(params);

        return new DataTableReasult<>(draw,userList,count,filterCount);
    }

    /**
     * 验证账号是否可用
     * @param username
     * @return
     */
    @RequestMapping(value = "/users/checkUsername",method = RequestMethod.GET)
    @ResponseBody
    public String checkUsername(String username){
        User user = userService.findUserByUsername(username);
        if(user == null){
            return "true";
        }else {
            return "false";
        }
    }


    /**
     * 添加用户
     * @param user
     * @return
     */
    @RequestMapping(value = "/users/new",method = RequestMethod.POST)
    @ResponseBody
    public String addUser(User user){
        userService.addUser(user);
        return "success";
    }

    /**
     * 重置密码
     * @param id
     * @return
     */
    @RequestMapping(value = "/users/resetpassword",method = RequestMethod.POST)
    @ResponseBody
    public String resetpassword(Integer id){
        userService.resetPasswordById(id);
        return "success";
    }

    /**
     * 根据用户ID显示用户JSON
     * @param id
     * @return
     */
    @RequestMapping(value = "/users/{id:\\d+}.json",method = RequestMethod.GET)
    @ResponseBody
    public JsonResult showUser(@PathVariable Integer id){
        User user = userService.findUserById(id);
        if(user == null){
            return new JsonResult("找不到"+id+"对应的用户");
        }else{
            return new JsonResult(user);
        }

    }

    @RequestMapping(value = "/users/edit",method = RequestMethod.POST)
    @ResponseBody
    public String editUser(User user){
        userService.updateUser(user);
        return "success";
    }



}
