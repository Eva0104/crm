package com.zhuxiaoxue.service;

import com.google.common.collect.Maps;
import com.zhuxiaoxue.mapper.CustomerMapper;
import com.zhuxiaoxue.pojo.Customer;
import com.zhuxiaoxue.util.ShiroUtil;
import com.zhuxiaoxue.util.Strings;
import org.apache.commons.lang3.StringUtils;
import org.springframework.transaction.annotation.Transactional;

import javax.inject.Inject;
import javax.inject.Named;
import java.util.List;
import java.util.Map;

@Named
public class CustomerService {

    @Inject
    private CustomerMapper customerMapper;

    /**
     * 保存新客户
     * @param customer
     */
    public void addCustomer(Customer customer) {
        if(customer.getCompanyid() != null){
            Customer company = customerMapper.findByid(customer.getCompanyid());
            customer.setCompanyname(company.getName());
        }
        customer.setUserid(ShiroUtil.getCurrentUserId());
        customer.setPinyin(Strings.toPinyin(customer.getName()));
        customerMapper.save(customer);
    }

    /**
     * 根据条件查询客户
     * @param params
     * @return
     */
    public List<Customer> findAllByParams(Map<String, Object> params) {

        if(ShiroUtil.isEmployee()){
            Integer userid = ShiroUtil.getCurrentUserId();
            params.put("userid",userid);
        }
        return customerMapper.findByParams(params);
    }


    /**
     * 根据条件获取客户数量
     * @param params
     * @return
     */
    public Long countByParams(Map<String, Object> params) {

        if(ShiroUtil.isEmployee()){
            Integer userid = ShiroUtil.getCurrentUserId();
            params.put("userid",userid);
        }
        return customerMapper.countByParams(params);
    }

    public Long count() {
        if(ShiroUtil.isEmployee()){
            Map<String,Object> params = Maps.newHashMap();
            Integer userid = ShiroUtil.getCurrentUserId();
            params.put("userid",userid);
            return customerMapper.countByParams(params);
        }
        return customerMapper.count();
    }

    public List<Customer> findAllCompany() {
        return customerMapper.findByType(Customer.CUSTOMER_COMPANY);
    }

    @Transactional
    public void delCustomerById(Integer id) {
        Customer customer = customerMapper.findByid(id);
        if (customer != null) {
            if (customer.getType().equals(Customer.CUSTOMER_COMPANY)) {
                List<Customer> customerList = customerMapper.findByCompanyid(id);

                for (Customer cust : customerList) {
                    cust.setCompanyid(null);
                    cust.setCompanyname(null);
                    customerMapper.updateByid(cust);
                }
            }
            //TODO 删除关联的项目
            //TODO 删除关联的代办事项
            customerMapper.delById(id);
        }
    }

    public Customer findById(Integer id) {
        return customerMapper.findCustomerById(id);
    }

    /**
     * 修改客戶信息
     * @param customer
     */
    public void update(Customer customer) {

        if(customer.getType().equals(Customer.CUSTOMER_COMPANY)){
            List<Customer> customerList = customerMapper.findByCompanyid(customer.getId());
            for(Customer cust : customerList){
                cust.setCompanyid(customer.getId());
                cust.setCompanyname(customer.getName());

                customerMapper.updateByid(cust);
            }
        }else {
            if(customer.getCompanyid() != null){
                Customer company = customerMapper.findByid(customer.getCompanyid());
                customer.setCompanyname(company.getName());
            }
        }
        customer.setPinyin(Strings.toPinyin(customer.getName()));
        customerMapper.updateByid(customer);
    }

    /**
     * 公开客户
     * @param customer
     */
    public void openCustomer(Customer customer){
        customer.setUserid(null);
        customerMapper.updateByid(customer);
    }


    /**
     * 转移客户
     * @param customer
     * @param userid
     */
    public void moveCustomer(Customer customer,Integer userid){
        customer.setUserid(userid);
        customerMapper.updateByid(customer);
    }

    /**
     * 根据公司ID查找对应公司的客户
     * @param id
     * @return
     */
    public List<Customer> findByCompanyId(Integer id) {
        return customerMapper.findByCompanyid(id);
    }

    /**
     * 将客户信息生成MeCard
     * @param id
     * @return
     */
    public String makeMeCard(Integer id){
        Customer customer = customerMapper.findByid(id);
        StringBuilder mecard = new StringBuilder("MECARD:");

        if(StringUtils.isNotEmpty(customer.getName())){
            mecard.append("N:" + customer.getName() + ";");
        }
        if(StringUtils.isNotEmpty(customer.getTel())){
            mecard.append("TEL:"+customer.getTel()+ ";");
        }
        if(StringUtils.isNotEmpty(customer.getEmail())){
            mecard.append("EMAIL:"+customer.getEmail()+ ";");
        }
        if(StringUtils.isNotEmpty(customer.getAddress())){
            mecard.append("ADR:"+customer.getAddress()+ ";");
        }
        if(StringUtils.isNotEmpty(customer.getCompanyname())){
            mecard.append("ORG:"+customer.getCompanyname()+ ";");
        }
        mecard.append(";");
        return mecard.toString();
    }

    public List<Customer> findAllCustomer() {

        if(ShiroUtil.isEmployee()){
            Integer userid = ShiroUtil.getCurrentUserId();
            return customerMapper.findCustomerByUserId(userid);
        }
        return customerMapper.findAllCustomer();
    }
}
