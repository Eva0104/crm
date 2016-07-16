package com.zhuxiaoxue.service;

import com.zhuxiaoxue.mapper.CustomerMapper;
import com.zhuxiaoxue.mapper.SalesFileMapper;
import com.zhuxiaoxue.mapper.SalesLogMapper;
import com.zhuxiaoxue.mapper.SalesMapper;
import com.zhuxiaoxue.pojo.Customer;
import com.zhuxiaoxue.pojo.Sales;
import com.zhuxiaoxue.pojo.SalesFile;
import com.zhuxiaoxue.pojo.SalesLog;
import com.zhuxiaoxue.util.ShiroUtil;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.transaction.annotation.Transactional;

import javax.inject.Inject;
import javax.inject.Named;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Named
public class SalesService {

    @Value("${imagePath}")
    private String savePath;

    @Inject
    private SalesMapper salesMapper;

    @Inject
    private SalesLogMapper salesLogMapper;

    @Inject
    private SalesFileMapper salesFileMapper;

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

    /**
     * 新增机会 并保存salseLog数据
     * @param sales
     */
    @Transactional
    public void addSales(Sales sales) {

        Integer custid = sales.getCustid();
        Customer customer = customerMapper.findCustomerById(custid);
        String custname = customer.getName();

        sales.setCustname(custname);
        sales.setUserid(ShiroUtil.getCurrentUserId());
        sales.setUsername(ShiroUtil.getCurrentUserRealname());

        salesMapper.save(sales);
        SalesLog salesLog = new SalesLog(sales.getId(),sales.getProgress(),SalesLog.TYPE_AUTO);
        salesLogMapper.saveSalesLog(salesLog);
    }

    public Sales findByid(Integer id) {
        return salesMapper.findByid(id);
    }

    public Sales findByname(String name) {
        return salesMapper.findByname(name);
    }

    public List<SalesFile> findAllFileBySalesid(Integer id) {
        return salesFileMapper.findAllBySalesid(id);
    }

    public void saveFile(InputStream inputStream, String originalFilename, long size, String contentType, Integer salesid) {
        SalesFile salesFile = new SalesFile();
        try {
            FileOutputStream fileOutputStream = new FileOutputStream(new File(savePath,originalFilename));
            IOUtils.copy(inputStream,fileOutputStream);

            fileOutputStream.flush();
            fileOutputStream.close();
            inputStream.close();
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException();
        }
        salesFile.setSize(FileUtils.byteCountToDisplaySize(size));
        salesFile.setContenttype(contentType);
        salesFile.setName(originalFilename);
        salesFile.setSalesid(salesid);

        salesFileMapper.save(salesFile);
    }

    public SalesFile findSalesFileByid(Integer id) {
        return salesFileMapper.findAllByid(id);
    }

    @Transactional
    public void delSales(Integer salesid) {
        Sales sales = salesMapper.findByid(salesid);
        if(sales != null){
            List<SalesFile> salesFileList = salesFileMapper.findAllBySalesid(salesid);
            if(!salesFileList.isEmpty()){
                salesFileMapper.delFile(salesFileList);
            }

            List<SalesLog> salesLogList = salesLogMapper.findBySalesid(salesid);
            if(!salesLogList.isEmpty()){
                salesLogMapper.delLog(salesLogList);
            }
        }
        salesMapper.delByid(salesid);
    }
}
