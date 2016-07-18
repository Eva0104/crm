package com.zhuxiaoxue.mapper;

import com.zhuxiaoxue.pojo.Task;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Eric on 2016/7/18.
 */
public interface TaskMapper {
    List<Task> findByUserid(@Param("userid") Integer userid,@Param("start") String start, @Param("end") String end);

    void add(Task task);
}
