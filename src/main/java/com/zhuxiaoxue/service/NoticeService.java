package com.zhuxiaoxue.service;

import com.zhuxiaoxue.mapper.NoticeMapper;
import com.zhuxiaoxue.pojo.Notice;
import com.zhuxiaoxue.util.ShiroUtil;

import javax.inject.Inject;
import javax.inject.Named;
import java.util.List;
import java.util.Map;

@Named
public class NoticeService {

    @Inject
    private NoticeMapper noticeMapper;
    public void addNotice(Notice notice) {
        notice.setRealname(ShiroUtil.getCurrentUserRealname());
        notice.setUserid(ShiroUtil.getCurrentUserId());
        noticeMapper.save(notice);
    }

    public List<Notice> findAll() {
        return noticeMapper.findAll();
    }

    public List<Notice> findNoticeByParams(Map<String, Object> params) {
        return noticeMapper.findNoticeByParams(params);
    }

    public Long findCount() {
        return noticeMapper.count();
    }

    public Long findFilterCount(Map<String, Object> params) {
        return noticeMapper.findFilterCount(params);
    }
}
