package com.zhuxiaoxue.controller;

import com.google.common.collect.Maps;
import com.zhuxiaoxue.dto.DataTableReasult;
import com.zhuxiaoxue.dto.JsonResult;
import com.zhuxiaoxue.pojo.Customer;
import com.zhuxiaoxue.pojo.Sales;
import com.zhuxiaoxue.service.CustomerService;
import com.zhuxiaoxue.service.SalesService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/sales")
public class SalesController {

    @Inject
    private SalesService salesService;
    @Inject
    private CustomerService customerService;

    @RequestMapping(method = RequestMethod.GET)
    public String list(Model model){
        List<Customer> customerList = customerService.findAllCustomer();
        model.addAttribute("customerList",customerList);
        return "/sales/list";
    }

    @RequestMapping(value = "/list",method = RequestMethod.GET)
    @ResponseBody
    public DataTableReasult<Sales> showSales(HttpServletRequest request){
        String draw = request.getParameter("draw");
        String start = request.getParameter("start");
        String length = request.getParameter("length");
        String keyword = request.getParameter("search[value]");

        Map<String,Object> params = Maps.newHashMap();
        params.put("start",start);
        params.put("length",length);
        params.put("keyword",keyword);

        List<Sales> salesList = salesService.findAllByparams(params);
        Long count = salesService.count();
        Long filterCount = salesService.countByParams(params);

        return new DataTableReasult<>(draw,salesList,count,filterCount);
    }

    @RequestMapping(value = "/add",method = RequestMethod.POST)
    @ResponseBody
    public String addSales(Sales sales){
        salesService.addSales(sales);
        return "success";
    }

    @RequestMapping(value = "/{id:\\d+}",method = RequestMethod.GET)
    public String showOne(@PathVariable Integer id,Model model){
        Sales sales = salesService.findByid(id);
        model.addAttribute("sales",sales);
        return "/sales/view";
    }
}
