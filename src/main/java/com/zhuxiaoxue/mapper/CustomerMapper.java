package com.zhuxiaoxue.mapper;

import com.zhuxiaoxue.pojo.Customer;

import java.util.List;
import java.util.Map;

/**
 * Created by Eric on 2016/7/13.
 */
public interface CustomerMapper {

    void save(Customer customer);

    List<Customer> findByParams(Map<String, Object> params);

    Long countByParams(Map<String, Object> params);

    Long count();

    List<Customer> findByType(String type);

    Customer findByid(Integer companyid);

    List<Customer> findByCompanyid(Integer id);

    void delById(Integer id);

    void updateByid(Customer customer);

    Customer findCustomerById(Integer id);
}
