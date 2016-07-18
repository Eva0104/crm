package com.zhuxiaoxue.controller;

import com.zhuxiaoxue.dto.JsonResult;
import com.zhuxiaoxue.mapper.TaskMapper;
import com.zhuxiaoxue.pojo.Task;
import com.zhuxiaoxue.service.TaskService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.inject.Inject;
import java.util.List;

@Controller
@RequestMapping("/task")
public class TaskController {

    @Inject
    private TaskService taskService;

    @RequestMapping(method = RequestMethod.GET)
    public String list(){
        return "/task/view";
    }

    /**
     * 查询当前用户的待办事项
     * @param start
     * @param end
     * @return
     */
    @RequestMapping(value = "/load",method = RequestMethod.GET)
    @ResponseBody
    public List<Task> showAll(String start, String end){
        return taskService.findTaskByuserid(start,end);
    }


    @RequestMapping(value = "/new",method = RequestMethod.POST)
    @ResponseBody
    public JsonResult add(Task task,String hour,String min){
        taskService.save(task,hour,min);
        return new JsonResult(task);
    }

}
