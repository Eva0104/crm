package com.zhuxiaoxue.mapper;

import com.zhuxiaoxue.pojo.Sales;

import java.util.List;
import java.util.Map;

/**
 * Created by Eric on 2016/7/15.
 */
public interface SalesMapper {

    List<Sales> findAllByParams(Map<String, Object> params);

    Long count();

    Long countByparams(Map<String, Object> params);

    void save(Sales sales);

    Sales findByid(Integer id);
}
