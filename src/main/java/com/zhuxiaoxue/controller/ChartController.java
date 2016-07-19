package com.zhuxiaoxue.controller;

import com.zhuxiaoxue.pojo.Customer;
import com.zhuxiaoxue.service.ChartService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.inject.Inject;

@Controller
@RequestMapping("/chart")
public class ChartController {

    @Inject
    private ChartService chartService;

    /**
     *
     * @param model
     * @param start
     * @param end
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    public String newCustomer(Model model,
                              @RequestParam(required = false,defaultValue = "")String start,
                              @RequestParam(required = false,defaultValue = "")String end){
        //新增客戶量
        Long newCustomerCount = chartService.newCustomerCount(start,end);
        model.addAttribute("newCustomerCount",newCustomerCount);

        //完成交易量
        Long finishSalesCount = chartService.finishSalesCount(start,end);
        model.addAttribute("finishSalesCount",finishSalesCount);

        //交易金額
        Float finishSalesMoney = chartService.finishSalesMoney(start,end);
        model.addAttribute("finishSalesMoney",finishSalesMoney);
        return "chart/view";
    }
}
