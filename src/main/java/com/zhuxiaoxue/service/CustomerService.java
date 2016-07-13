package com.zhuxiaoxue.service;

import com.zhuxiaoxue.mapper.CustomerMapper;
import com.zhuxiaoxue.pojo.Customer;
import com.zhuxiaoxue.util.ShiroUtil;

import javax.inject.Inject;
import javax.inject.Named;
import java.util.List;
import java.util.Map;

@Named
public class CustomerService {

    @Inject
    private CustomerMapper customerMapper;

    public List<Customer> findAllByCreateUserid() {
        Integer userid = ShiroUtil.getCurrentUserId();
        return customerMapper.findByUserId(userid);
    }

    public void addCustomer(Customer customer) {
        customerMapper.save(customer);
    }

    /**
     * 根据条件查询客户
     * @param params
     * @return
     */
    public List<Customer> findAllByParams(Map<String, Object> params) {
        return customerMapper.findByParams(params);
    }


    /**
     * 根据条件获取客户数量
     * @param params
     * @return
     */
    public Long findCountByParams(Map<String, Object> params) {
        return customerMapper.findCountByParams(params);
    }

    public Long findCount() {
        return customerMapper.count();
    }
}
