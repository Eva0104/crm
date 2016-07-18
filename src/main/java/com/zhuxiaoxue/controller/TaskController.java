package com.zhuxiaoxue.controller;

import com.zhuxiaoxue.dto.JsonResult;
import com.zhuxiaoxue.mapper.TaskMapper;
import com.zhuxiaoxue.pojo.Task;
import com.zhuxiaoxue.service.TaskService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
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
     * 查询当前用户的日程
     * @param start
     * @param end
     * @return
     */
    @RequestMapping(value = "/load",method = RequestMethod.GET)
    @ResponseBody
    public List<Task> showAll(String start, String end){
        return taskService.findTaskByuserid(start,end);
    }


    /**
     * 新增日程
     * @param task
     * @param hour 提醒日期(remindertime)的小时部分
     * @param min 提醒日期的分钟部分
     * @return
     */
    @RequestMapping(value = "/new",method = RequestMethod.POST)
    @ResponseBody
    public JsonResult addTask(Task task,String hour,String min){
        taskService.save(task,hour,min);
        return new JsonResult(task);
    }

    /**
     * 删除日程
     * @param id
     * @return
     */
    @RequestMapping(value = "/del/{id:\\d+}",method = RequestMethod.GET)
    @ResponseBody
    public String delTask(@PathVariable Integer id){
        taskService.deltaskByid(id);
        return "success";
    }


}
