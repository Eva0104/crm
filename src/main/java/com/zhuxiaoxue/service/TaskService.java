package com.zhuxiaoxue.service;

import com.zhuxiaoxue.mapper.TaskMapper;
import com.zhuxiaoxue.pojo.Task;
import com.zhuxiaoxue.util.ShiroUtil;
import org.apache.commons.lang3.StringUtils;
import org.joda.time.DateTime;

import javax.inject.Inject;
import javax.inject.Named;
import java.util.Date;
import java.util.List;

@Named
public class TaskService {

    @Inject
    private TaskMapper taskMapper;

    public List<Task> findTaskByuserid(String start, String end) {

        return taskMapper.findByUserid(ShiroUtil.getCurrentUserId(),start,end);
    }

    public void save(Task task, String hour, String min) {
        if(StringUtils.isNotEmpty(hour) && StringUtils.isNotEmpty(min)){
            String remindertime = task.getStart() + "" + hour + ":" + min + "00";

            //TODO 微信提醒
            task.setRemindertime(remindertime);
        }
        task.setUserid(ShiroUtil.getCurrentUserId());
        taskMapper.add(task);
    }

    public void deltaskByid(Integer id) {
        taskMapper.delByid(id);
    }

    public Task updateByid(Integer id) {
        Task task = taskMapper.findByid(id);
        task.setColor("#cccccc");
        task.setDone(true);
        taskMapper.update(task);
        return task;
    }

    public List<Task> findtimeoutTask() {
        String today = DateTime.now().toString("yyyy-MM-dd");
        return taskMapper.findTimeOutTask(ShiroUtil.getCurrentUserId(),today);
    }

    public List<Task> findTaskByCustid(Integer custid) {
        return taskMapper.findByCustid(custid);
    }

    public List<Task> findTaskBySalesid(Integer salesid) {
        return taskMapper.findBySalesid(salesid);
    }
}
