package com.zhuxiaoxue.mapper;

import com.zhuxiaoxue.pojo.Customer;

import java.util.List;
import java.util.Map;

/**
 * Created by Eric on 2016/7/13.
 */
public interface CustomerMapper {
    List<Customer> findByUserId(Integer userid);

    void save(Customer customer);

    List<Customer> findByParams(Map<String, Object> params);

    Long findCountByParams(Map<String, Object> params);

    Long count();
}
