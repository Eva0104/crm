package com.zhuxiaoxue.util;

import com.zhuxiaoxue.pojo.User;
import org.apache.shiro.SecurityUtils;

public class ShiroUtil {

    public static User getCurrentUser(){
        return  (User) SecurityUtils.getSubject().getPrincipal();
    }

    public static Integer getCurrentUserId(){
        return getCurrentUser().getId();
    }

    public static String getCurrentUsername(){
        return getCurrentUser().getUsername();
    }

    public static String getCurrentUserRealname() {
        return getCurrentUser().getRealname();
    }
}
