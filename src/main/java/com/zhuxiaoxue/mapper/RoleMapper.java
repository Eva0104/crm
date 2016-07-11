package com.zhuxiaoxue.mapper;

import com.zhuxiaoxue.pojo.Role;

import java.util.List;

public interface RoleMapper {
    Role findById(Integer id);

    List<Role> findAll();
}
