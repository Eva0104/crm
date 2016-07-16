package com.zhuxiaoxue.mapper;

import com.zhuxiaoxue.pojo.SalesLog;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Eric on 2016/7/15.
 */
public interface SalesLogMapper {

    void saveSalesLog(SalesLog salesLog);

    List<SalesLog> findBySalesid(Integer id);

    void delLog(List<SalesLog> salesLogList);
}
