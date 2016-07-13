package com.zhuxiaoxue.service;

import com.zhuxiaoxue.mapper.NoticeMapper;
import com.zhuxiaoxue.pojo.Notice;
import com.zhuxiaoxue.util.ShiroUtil;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Value;

import javax.inject.Inject;
import javax.inject.Named;
import java.io.*;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Named
public class NoticeService {

    @Value("${imagePath}")
    private String imagSavePath;

    /**
     * 新增公告
     */
    @Inject
    private NoticeMapper noticeMapper;
    public void addNotice(Notice notice) {
        notice.setRealname(ShiroUtil.getCurrentUserRealname());
        notice.setUserid(ShiroUtil.getCurrentUserId());
        noticeMapper.save(notice);
    }

    /**
     * 查询所有公告
     * @return
     */
    public List<Notice> findAll() {
        return noticeMapper.findAll();
    }

    /**
     * 根据条件查询公告
     * @param params
     * @return
     */
    public List<Notice> findNoticeByParams(Map<String, Object> params) {
        return noticeMapper.findNoticeByParams(params);
    }

    /**
     * 查询公告总数量
     * @return
     */
    public Long findCount() {
        return noticeMapper.count();
    }

    /**
     * 查询过滤后的公告数量
     * @param params
     * @return
     */
    public Long findFilterCount(Map<String, Object> params) {
        return noticeMapper.findFilterCount(params);
    }

    /**
     * 根据ID查找对应的公告
     * @param id
     * @return
     */
    public Notice findNoticeById(Integer id) {
        return noticeMapper.findById(id);
    }

    /**
     * 保存在线编辑器中上传的文件
     * @param inputStream
     * @param filename
     * @return
     */
    public String saveImg(InputStream inputStream,String filename) throws IOException {
        String extName = filename.substring(filename.lastIndexOf("."));
        String newFilename = UUID.randomUUID().toString() + extName;

        FileOutputStream fileOutputStream = new FileOutputStream(new File(imagSavePath,newFilename));

        IOUtils.copy(inputStream,fileOutputStream);
        fileOutputStream.flush();
        fileOutputStream.close();
        inputStream.close();
        return "/preview/"+newFilename;
    }
}
