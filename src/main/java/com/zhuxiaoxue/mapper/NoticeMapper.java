package com.zhuxiaoxue.mapper;

import com.zhuxiaoxue.pojo.Notice;

import java.util.List;
import java.util.Map;

/**
 * Created by Eric on 2016/7/11.
 */
public interface NoticeMapper {

    void save(Notice notice);

    List<Notice> findAll();

    List<Notice> findNoticeByParams(Map<String, Object> params);
    Long count();

    Long findFilterCount(Map<String, Object> params);

    Notice findById(Integer id);
}
