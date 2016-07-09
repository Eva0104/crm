package com.zhuxiaoxue.mapper;

import com.zhuxiaoxue.pojo.UserLog;

import java.util.List;
import java.util.Map;

public interface UserLogMapper {
    void save(UserLog userLog);

    List<UserLog> findByParams(Map<String, Object> params);

    Long countByUserid(Map<String, Object> map);
}
