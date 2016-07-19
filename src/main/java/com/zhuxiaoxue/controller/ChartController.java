package com.zhuxiaoxue.controller;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.zhuxiaoxue.pojo.Customer;
import com.zhuxiaoxue.service.ChartService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.inject.Inject;
import java.util.List;
import java.util.Map;

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



    @RequestMapping(value = "/progress/data",method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String,Object>> loadPieData(@RequestParam(required = false,defaultValue = "")String start,
                                                @RequestParam(required = false,defaultValue = "")String end){
        return chartService.loadPieData(start,end);
    }

    @RequestMapping(value = "/user/price",method = RequestMethod.GET)
    @ResponseBody
    public Map<String,Object> totalUserMoney(@RequestParam(required = false,defaultValue = "")String start,
                                                   @RequestParam(required = false,defaultValue = "")String end){
        List<Map<String,Object>> data = chartService.loadBarData(start,end);

        List<String> names = Lists.newArrayList();
        List<String> price = Lists.newArrayList();

        for(Map<String,Object> map : data){
            for(Map.Entry<String,Object> entry : map.entrySet()){
                if(entry.getKey().equals("realname")){
                    names.add(entry.getValue().toString());
                }
                if(entry.getKey().equals("price")){
                    price.add(entry.getValue().toString());
                }
            }
        }
        Map<String,Object> result = Maps.newHashMap();
        result.put("name",names);
        result.put("price",price);
        return result;
    }
}
