package com.zhuxiaoxue.mapper;

import com.zhuxiaoxue.pojo.SalesFile;

import java.util.List;

/**
 * Created by Eric on 2016/7/16.
 */
public interface SalesFileMapper {
    List<SalesFile> findAllBySalesid(Integer id);

    void save(SalesFile salesFile);

    SalesFile findAllByid(Integer id);
}
