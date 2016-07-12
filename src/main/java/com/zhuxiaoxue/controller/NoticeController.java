package com.zhuxiaoxue.controller;

import com.google.common.collect.Maps;
import com.zhuxiaoxue.dto.DataTableReasult;
import com.zhuxiaoxue.pojo.Notice;
import com.zhuxiaoxue.service.NoticeService;
import com.zhuxiaoxue.util.Strings;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
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
}
