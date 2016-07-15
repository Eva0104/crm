package com.zhuxiaoxue.service;

import com.zhuxiaoxue.mapper.CustomerMapper;
import com.zhuxiaoxue.mapper.SalesMapper;
import com.zhuxiaoxue.pojo.Customer;
import com.zhuxiaoxue.pojo.Sales;
import com.zhuxiaoxue.util.ShiroUtil;

import javax.inject.Inject;
import javax.inject.Named;
import java.util.List;
import java.util.Map;

@Named
public class SalesService {

    @Inject
    private SalesMapper salesMapper;
    @Inject
    private CustomerMapper customerMapper;


    public List<Sales> findAllByparams(Map<String, Object> params) {

        if(ShiroUtil.isEmployee()){
            params.put("userid",ShiroUtil.getCurrentUserId());
        }

        return salesMapper.findAllByParams(params);
    }

    public Long count() {
        return salesMapper.count();
    }

    public Long countByParams(Map<String, Object> params) {

        if(ShiroUtil.isEmployee()){
            params.put("userid",ShiroUtil.getCurrentUserId());
        }
        return salesMapper.countByparams(params);
    }

    public void addSales(Sales sales) {

        Integer custid = sales.getCustid();
        Customer customer = customerMapper.findCustomerById(custid);
        String custname = customer.getName();

        sales.setCustname(custname);
        sales.setUserid(ShiroUtil.getCurrentUserId());
        sales.setUsername(ShiroUtil.getCurrentUserRealname());

        salesMapper.save(sales);
    }

    public Sales findByid(Integer id) {
        return salesMapper.findByid(id);
    }
}
