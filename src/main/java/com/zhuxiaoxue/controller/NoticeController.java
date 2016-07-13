package com.zhuxiaoxue.controller;

import com.google.common.collect.Maps;
import com.zhuxiaoxue.dto.DataTableReasult;
import com.zhuxiaoxue.exception.NotFoundException;
import com.zhuxiaoxue.pojo.Notice;
import com.zhuxiaoxue.service.NoticeService;
import com.zhuxiaoxue.util.Strings;
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
@RequestMapping("/notice")
public class NoticeController {

    @Inject
    private NoticeService noticeService;

    @RequestMapping(method = RequestMethod.GET)
    public String list(){
        return "notice/list";
    }

    /**
     * 公告列表
     * @param request
     * @return
     */
    @RequestMapping(value = "/list",method = RequestMethod.GET)
    @ResponseBody
    public DataTableReasult<Notice> showNotice(HttpServletRequest request){
        String draw = request.getParameter("draw");
        String start = request.getParameter("start");
        String length = request.getParameter("length");
        String keyword = request.getParameter("search[value]");

        keyword = Strings.toUTF8(keyword);
        Map<String,Object> params = Maps.newHashMap();
        params.put("start",start);
        params.put("length",length);
        params.put("keyword",keyword);

        List<Notice> noticeList = noticeService.findNoticeByParams(params);
        Long count = noticeService.findCount();
        Long filterCount = noticeService.findFilterCount(params);
        return new DataTableReasult<>(draw,noticeList,count,filterCount);
    }

    /**
     * 根据ID查询公告内容
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "/{id:\\d+}",method = RequestMethod.GET)
    public String noticeLoad(@PathVariable Integer id,Model model){
        Notice notice = noticeService.findNoticeById(id);
        if(notice == null){
            throw new NotFoundException();
        }else {
            model.addAttribute("notice",notice);
        }
        return "/notice/view";
    }

    /**
     * 新增公告
     * @return
     */
    @RequestMapping(value = "/new",method = RequestMethod.GET)
    public String add(){
        return "notice/new";
    }

    @RequestMapping(value = "/new",method = RequestMethod.POST)
    public String addNotice(Notice notice){
        noticeService.addNotice(notice);
        return "notice/list";
    }

    /**
     * 含有图片的公告
     * @param file
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/img/load",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> upload(MultipartFile file) throws IOException {
        Map<String,Object> map = Maps.newHashMap();
        if(file.isEmpty()){
            map.put("success",false);
            map.put("message","请选择文件");
        }else {
            map.put("success",true);
            map.put("file_path",noticeService.saveImg(file.getInputStream(),file.getOriginalFilename()));
        }
        return map;
    }
}
