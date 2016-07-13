package com.zhuxiaoxue.controller;

import com.google.common.collect.Maps;
import com.zhuxiaoxue.dto.DataTableReasult;
import com.zhuxiaoxue.pojo.Customer;
import com.zhuxiaoxue.service.CustomerService;
import com.zhuxiaoxue.util.ShiroUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/customer")
public class CustomerController {

    @Inject
    private CustomerService customerService;

    @RequestMapping(method = RequestMethod.GET)
    public String list(Model model){
        return "/customer/list";
    }
    @RequestMapping(value = "/list",method = RequestMethod.GET)
    @ResponseBody
    public DataTableReasult<Customer> showAll(HttpServletRequest request){
        String draw = request.getParameter("draw");
        String start = request.getParameter("start");
        String length = request.getParameter("length");
        Integer userid = ShiroUtil.getCurrentUserId();
        String keyword = request.getParameter("search[value]");

        Map<String,Object> params = Maps.newHashMap();
        params.put("start",start);
        params.put("length",length);
        params.put("keyword",keyword);
        params.put("userid",userid);

        List<Customer> customerList = customerService.findAllByParams(params);
        Long count = customerService.findCount();
        Long filterCount = customerService.findCountByParams(params);

        return new DataTableReasult<>(draw,customerList,count,filterCount);
    }

    @RequestMapping(value = "/new",method = RequestMethod.POST)
    @ResponseBody
    public String addCustomer(Customer customer){
        customer.setUserid(ShiroUtil.getCurrentUserId());
        customerService.addCustomer(customer);
        return "success";
    }

}
