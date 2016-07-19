package com.zhuxiaoxue.service;

import com.zhuxiaoxue.mapper.CustomerMapper;
import com.zhuxiaoxue.mapper.SalesMapper;
import org.apache.commons.lang3.StringUtils;
import org.joda.time.DateTime;

import javax.inject.Inject;
import javax.inject.Named;
import java.util.List;
import java.util.Map;

@Named
public class ChartService {

    @Inject
    private CustomerMapper customerMapper;

    @Inject
    private SalesMapper salesMapper;

    public Long newCustomerCount(String start, String end) {
        DateTime now = DateTime.now();
        if(StringUtils.isEmpty(start)){
            start = now.dayOfMonth().withMinimumValue().toString("yyyy-MM-dd");
        }
        if(StringUtils.isEmpty(end)){
            end = now.toString("yyyy-MM-dd");
        }

        return customerMapper.newCustomerCount(start,end);
    }

    public Long finishSalesCount(String start, String end) {

        DateTime now = DateTime.now();
        if(StringUtils.isEmpty(start)){
            start = now.dayOfMonth().withMinimumValue().toString("yyyy-MM-dd");
        }
        if(StringUtils.isEmpty(end)){
            end = now.toString("yyyy-MM-dd");
        }
        return salesMapper.finishSalesCount(start,end);
    }

    public Float finishSalesMoney(String start, String end) {

        DateTime now = DateTime.now();
        if(StringUtils.isEmpty(start)){
            start = now.dayOfMonth().withMinimumValue().toString("yyyy-MM-dd");
        }
        if(StringUtils.isEmpty(end)){
            end = now.toString("yyyy-MM-dd");
        }
        return salesMapper.finishSalesMoney(start,end);
    }

    public List<Map<String, Object>> loadPieData(String start, String end) {

        DateTime now = DateTime.now();
        if(StringUtils.isEmpty(start)){
            start = now.dayOfMonth().withMinimumValue().toString("yyyy-MM-dd");
        }
        if(StringUtils.isEmpty(end)){
            end = now.toString("yyyy-MM-dd");
        }
        return salesMapper.loadPieData(start,end);
    }

    public List<Map<String,Object>> loadBarData(String start, String end){
        DateTime now = DateTime.now();
        if(StringUtils.isEmpty(start)){
            start = now.dayOfMonth().withMinimumValue().toString("yyyy-MM-dd");
        }
        if(StringUtils.isEmpty(end)){
            end = now.toString("yyyy-MM-dd");
        }

        return salesMapper.totalUserMoney(start,end);
    }
}
