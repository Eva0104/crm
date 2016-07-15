package com.zhuxiaoxue.controller;

import com.google.common.collect.Maps;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.zhuxiaoxue.dto.DataTableReasult;
import com.zhuxiaoxue.dto.JsonResult;
import com.zhuxiaoxue.exception.ForbiddenException;
import com.zhuxiaoxue.exception.NotFoundException;
import com.zhuxiaoxue.pojo.Customer;
import com.zhuxiaoxue.pojo.User;
import com.zhuxiaoxue.service.CustomerService;
import com.zhuxiaoxue.service.UserService;
import com.zhuxiaoxue.util.ShiroUtil;
import com.zhuxiaoxue.util.Strings;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/customer")
public class CustomerController {

    @Inject
    private CustomerService customerService;

    @Inject
    private UserService userService;

    @RequestMapping(method = RequestMethod.GET)
    public String list(Model model){
        List<Customer> companyList = customerService.findAllCompany();
        System.out.println(companyList);
        model.addAttribute("companyList",companyList);
        return "/customer/list";
    }

    @RequestMapping(value = "/list",method = RequestMethod.GET)
    @ResponseBody
    public DataTableReasult<Customer> showAll(HttpServletRequest request){
        String draw = request.getParameter("draw");
        String start = request.getParameter("start");
        String length = request.getParameter("length");
        String keyword = request.getParameter("search[value]");

        Map<String,Object> params = Maps.newHashMap();
        params.put("start",start);
        params.put("length",length);
        params.put("keyword",keyword);

        List<Customer> customerList = customerService.findAllByParams(params);
        Long count = customerService.count();
        Long filterCount = customerService.countByParams(params);

        return new DataTableReasult<>(draw,customerList,count,filterCount);
    }

    /**
     * 保存新客户
     * @param customer
     * @return
     */
    @RequestMapping(value = "/new",method = RequestMethod.POST)
    @ResponseBody
    public String addCustomer(Customer customer){
        customerService.addCustomer(customer);
        return "success";
    }


    /**
     * 删除客户
     * @param id
     * @return
     */
    @RequestMapping(value = "/del/{id:\\d+}",method = RequestMethod.GET)
    @ResponseBody
    public String delCustomer(@PathVariable Integer id){
        customerService.delCustomerById(id);
        return "success";
    }


    @RequestMapping(value = "/edit/{id:\\d+}.json",method = RequestMethod.GET)
    @ResponseBody
    public JsonResult showCustomer(@PathVariable Integer id){
        Customer customer = customerService.findById(id);
        if(customer == null){
            throw new NotFoundException();
        }
        if(customer.getUserid() != null && !customer.getUserid().equals(ShiroUtil.getCurrentUserId()) && !ShiroUtil.isEmployer()){
            throw new NotFoundException();
        }
        return new JsonResult(customer);
    }

    /**
     * 修改客户信息
     * @param customer
     * @return
     */
    @RequestMapping(value = "/edit",method = RequestMethod.POST)
    @ResponseBody
    public String updateCustomer(Customer customer){
        customerService.update(customer);
        return "success";
    }

    /**
     * 显示客户个人主页
     * @param model
     * @param id
     * @return
     */
    @RequestMapping(value = "/{id:\\d+}",method = RequestMethod.GET)
    public String showCustomer(Model model,@PathVariable Integer id){
        Customer customer = customerService.findById(id);

        if(customer == null){
            throw new NotFoundException();
        }
        if(customer.getUserid() != null && !customer.getUserid().equals(ShiroUtil.getCurrentUserId()) && !ShiroUtil.isEmployer()){
            throw new ForbiddenException();
        }

        if(customer.getType().equals("company")){
            List<Customer> customerList = customerService.findByCompanyId(customer.getId());
            model.addAttribute("customerList",customerList);
        }

        //转移客户时显示所有用户
        List<User> userList = userService.findAll();
        model.addAttribute("userList",userList);

        model.addAttribute("customer",customer);

        return "/customer/view";
    }

    /**
     * 公开客户
     * @param id
     * @return
     */
    @RequestMapping(value = "/open/{id:\\d+}",method = RequestMethod.GET)
    public String openCustomer(@PathVariable Integer id){
        Customer customer = customerService.findById(id);
        if(customer == null){
            throw new NotFoundException();
        }
        if(customer.getUserid() != null && !customer.getUserid().equals(ShiroUtil.getCurrentUserId()) && !ShiroUtil.isEmployer()){
            throw new ForbiddenException();
        }
        customerService.openCustomer(customer);
        return "redirect:/customer";
    }

    /**
     * 转移客户
     * @param id
     * @param userid
     * @return
     */
    @RequestMapping(value = "/moveCustomer",method = RequestMethod.POST)
    public String moveCustomer(Integer id,Integer userid){

        Customer customer = customerService.findById(id);
        if(customer == null){
            throw new NotFoundException();
        }
        if(customer.getUserid() != null && !customer.getUserid().equals(ShiroUtil.getCurrentUserId()) && !ShiroUtil.isEmployer()){
            throw new ForbiddenException();
        }
        customerService.moveCustomer(customer,userid);
        return "redirect:/customer";
    }


    @RequestMapping(value = "/qrcode/{id:\\d+}",method = RequestMethod.GET)
    public void makeQrcode(@PathVariable Integer id, HttpServletResponse response) throws WriterException, IOException {
        String meCard = customerService.makeMeCard(id);

        Map<EncodeHintType,String> hints = Maps.newConcurrentMap();

        hints.put(EncodeHintType.CHARACTER_SET,"UTF-8");

        BitMatrix bitMatrix = new MultiFormatWriter().encode(meCard, BarcodeFormat.QR_CODE,200,200,hints);

        OutputStream outputStream = response.getOutputStream();

        MatrixToImageWriter.writeToStream(bitMatrix,"png",outputStream);

        outputStream.flush();
        outputStream.close();
    }




}
