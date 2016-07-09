package com.zhuxiaoxue.controller;

import com.zhuxiaoxue.dto.DataTableReasult;
import com.zhuxiaoxue.exception.NotFoundException;
import com.zhuxiaoxue.pojo.User;
import com.zhuxiaoxue.pojo.UserLog;
import com.zhuxiaoxue.service.UserService;
import com.zhuxiaoxue.util.ShiroUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {

    @Inject
    private UserService userService;

    /**
     * 显示当前用户的登录日志
     *
     * @return
     */
    @RequestMapping(value = "/loginLog", method = RequestMethod.GET)
    public String log() {
        return "/setting/loglist";
    }

    /**
     * 使用dataTables显示数据
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/loginLog/load", method = RequestMethod.GET)
    @ResponseBody
    public DataTableReasult<UserLog> logLoad(HttpServletRequest request) {
        String draw = request.getParameter("draw");
        String start = request.getParameter("start");
        String length = request.getParameter("length");

        List<UserLog> userLogList = userService.findCurrentUserLog(start, length);

        Long count = userService.findCurrentUserLogcount();

        return new DataTableReasult<>(draw, userLogList, count, count);
    }

    @RequestMapping(value = "/validate/password", method = RequestMethod.GET)
    @ResponseBody
    public String validate(@RequestHeader("X-Requested-With") String xRequest, String oldpassword) {
        if ("XMLHttpRequest".equals(xRequest)) {
            User user = ShiroUtil.getCurrentUser();
            if (oldpassword.equals(user.getPassword())) {
                return "true";
            } else {
                return "false";
            }
        }else {
            throw new NotFoundException();
        }
    }

    /**
     * 修改密码
     *
     * @return
     */
    @RequestMapping(value = "/password", method = RequestMethod.GET)
    public String editPassword() {
        return "/setting/password";
    }

    @RequestMapping(value = "/password", method = RequestMethod.POST)
    @ResponseBody
    public String changePassword(String password) {
        userService.changePassword(password);
        return "success";
    }

}
