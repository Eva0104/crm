package com.zhuxiaoxue.mapper;

import com.zhuxiaoxue.pojo.User;

/**
 * Created by Eric on 2016/7/8.
 */
public interface UserMapper {

    User findByUsername(String username);

    void update(User user);
}
