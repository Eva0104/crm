package com.zhuxiaoxue.mapper;

import com.zhuxiaoxue.pojo.User;

import java.util.List;
import java.util.Map;

/**
 * Created by Eric on 2016/7/8.
 */
public interface UserMapper {

    User findByUsername(String username);

    void update(User user);

    List<User> findAllByParams(Map<String, Object> params);

    Long count();

    Long countByParams(Map<String, Object> params);

    void save(User user);

    User findUserById(Integer id);
}
