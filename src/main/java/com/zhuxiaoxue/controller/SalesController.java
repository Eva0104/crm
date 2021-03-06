package com.zhuxiaoxue.controller;

import com.google.common.collect.Maps;
import com.zhuxiaoxue.dto.DataTableReasult;
import com.zhuxiaoxue.dto.JsonResult;
import com.zhuxiaoxue.exception.ForbiddenException;
import com.zhuxiaoxue.exception.NotFoundException;
import com.zhuxiaoxue.pojo.*;
import com.zhuxiaoxue.service.CustomerService;
import com.zhuxiaoxue.service.SalesLogService;
import com.zhuxiaoxue.service.SalesService;
import com.zhuxiaoxue.service.TaskService;
import com.zhuxiaoxue.util.DateUtil;
import com.zhuxiaoxue.util.ShiroUtil;
import com.zhuxiaoxue.util.Strings;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/sales")
public class SalesController {

    @Inject
    private SalesService salesService;

    @Value("${imagePath}")
    private String savePath;

    @Inject
    private TaskService taskService;

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

        String name = request.getParameter("name");
        name= Strings.toUTF8(name);
        String progress = request.getParameter("progress");
        progress=Strings.toUTF8(progress);
        String startdate=request.getParameter("startdate");
        String enddate = request.getParameter("enddate");

        Map<String,Object> params = Maps.newHashMap();
        params.put("start",start);
        params.put("length",length);

        params.put("name",name);
        params.put("progress",progress);
        params.put("startdate",startdate);
        params.put("enddate",enddate);

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

        if(sales == null){
            throw new NotFoundException();
        }

        if( sales.getUserid()!= null && !sales.getUserid().equals(ShiroUtil.getCurrentUserId()) && !ShiroUtil.isEmployer()){
            throw new ForbiddenException();
        }

        model.addAttribute("sales",sales);

        //机会跟进信息
        List<SalesLog> salesLogList = salesLogService.findBySalesid(id);
        model.addAttribute("salesLogList",salesLogList);

        //相关文件
        List<SalesFile> salesFileList = salesService.findAllFileBySalesid(id);
        model.addAttribute("salesFileList",salesFileList);

        //待办事项
        List<Task> taskList = taskService.findTaskBySalesid(id);
        model.addAttribute("taskList",taskList);

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


    /**
     * 上传相关文件
     * @param file
     * @param id
     * @return
     * @throws IOException
     */
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

    /**
     * 下载文件
     * @param id
     * @return
     * @throws FileNotFoundException
     * @throws UnsupportedEncodingException
     */
    @RequestMapping(value = "/{id:\\d+}/downLoad",method = RequestMethod.GET)
    public ResponseEntity<InputStreamResource> downLoad(@PathVariable Integer id) throws FileNotFoundException, UnsupportedEncodingException {

        SalesFile salesFile = salesService.findSalesFileByid(id);

        File file = new File(savePath,salesFile.getName());

        if(!file.exists()){
            throw new NotFoundException();
        }
        FileInputStream fileInputStream = new FileInputStream(file);

        String fileName = salesFile.getName();
        fileName = new String(fileName.getBytes("UTF-8"),"ISO8859-1");

        return ResponseEntity
                .ok()
                .contentType(MediaType.parseMediaType(salesFile.getContenttype()))
                .contentLength(file.length())
                .header("Content-Disposition","attachment;filename=\""+fileName+"\"")
                .body(new InputStreamResource(fileInputStream));

    }


    /**
     * 删除进度表
     * @param id
     * @return
     */
    @RequestMapping(value = "/del/{id:\\d+}",method = RequestMethod.GET)
    public String delSales(@PathVariable Integer id){
        salesService.delSales(id);
        return "redirect:/sales";
    }

    /**
     * 新增待办事项
     * @param task
     * @param hour
     * @param min
     * @return
     */
    @RequestMapping(value = "/task/new",method = RequestMethod.POST)
    @ResponseBody
    public JsonResult addTask(Task task, String hour, String min){
        taskService.save(task,hour,min);
        return new JsonResult(task);
    }


}
