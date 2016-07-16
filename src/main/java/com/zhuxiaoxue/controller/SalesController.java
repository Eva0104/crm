package com.zhuxiaoxue.controller;

import com.google.common.collect.Maps;
import com.zhuxiaoxue.dto.DataTableReasult;
import com.zhuxiaoxue.exception.NotFoundException;
import com.zhuxiaoxue.pojo.Customer;
import com.zhuxiaoxue.pojo.Sales;
import com.zhuxiaoxue.pojo.SalesFile;
import com.zhuxiaoxue.pojo.SalesLog;
import com.zhuxiaoxue.service.CustomerService;
import com.zhuxiaoxue.service.SalesLogService;
import com.zhuxiaoxue.service.SalesService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/sales")
public class SalesController {

    @Inject
    private SalesService salesService;

    @Inject
    private SalesLogService salesLogService;

    @Inject
    private CustomerService customerService;


    /**
     * 机会列表
     * @param model
     * @return
     */
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

    /**
     * 新增机会
     * @param sales
     * @return
     */
    @RequestMapping(value = "/add",method = RequestMethod.POST)
    @ResponseBody
    public String addSales(Sales sales){
        salesService.addSales(sales);
        return "success";
    }


    /**
     * 显示每个机会主页
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "/{id:\\d+}",method = RequestMethod.GET)
    public String showOne(@PathVariable Integer id,Model model){
        //机会信息
        Sales sales = salesService.findByid(id);
        model.addAttribute("sales",sales);

        //机会跟进信息
        List<SalesLog> salesLogList = salesLogService.findBySalesid(id);
        model.addAttribute("salesLogList",salesLogList);

        //相关文件
        List<SalesFile> salesFileList = salesService.findAllFileBySalesid(id);
        model.addAttribute("salesFileList",salesFileList);

        return "/sales/view";
    }

    /**
     * 手动增加跟进记录
     * @param salesLog
     * @param id
     * @return
     */
    @RequestMapping(value = "/{id:\\d+}/addLog",method = RequestMethod.POST)
    public String addLog(SalesLog salesLog,@PathVariable Integer id){
        salesLogService.addLog(salesLog,id);
        return "redirect:/sales/"+id;
    }

    /**
     * 修改跟进状态
     * @param salesLog
     * @param id
     * @return
     */
    @RequestMapping(value = "/{id:\\d+}/editLog",method = RequestMethod.POST)
    public String editLog(SalesLog salesLog,@PathVariable Integer id){
        salesLogService.editLog(salesLog,id);
        return "redirect:/sales/"+id;
    }



    @RequestMapping(value = "/{id:\\d+}/fileUpload",method = RequestMethod.POST)
    @ResponseBody
    public String saveFile(MultipartFile file, @PathVariable Integer id) throws IOException {
        if (!file.isEmpty()) {
            salesService.saveFile(file.getInputStream(),file.getOriginalFilename(),file.getSize(),file.getContentType(),id);
        } else {
            throw new NotFoundException();
        }
        return "success";
    }

}
