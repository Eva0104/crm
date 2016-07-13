package com.zhuxiaoxue.service;

import com.zhuxiaoxue.mapper.DocumentMapper;
import com.zhuxiaoxue.pojo.Document;
import com.zhuxiaoxue.util.ShiroUtil;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Value;

import javax.inject.Inject;
import javax.inject.Named;
import java.io.*;
import java.util.List;
import java.util.UUID;

@Named
public class DocumentService {

    @Inject
    private DocumentMapper documentMapper;

    @Value("${imagePath}")
    private String savePath;

    /**
     * 根据id获取文件
     * @return
     */
    public List<Document> findAllByfid(Integer fid) {
        return documentMapper.findAllByfid(fid);
    }

    /**
     * 新建文件夹
     * @param name
     * @param fid
     */
    public void addDir(String name,Integer fid){

        Document document = new Document();
        document.setName(name);
        document.setFid(fid);
        document.setType(Document.TYPE_DIR);
        document.setCreateuser(ShiroUtil.getCurrentUserRealname());

        documentMapper.save(document);

    }

    /**
     * 保存上传文件
     * @param inputStream
     * @param originalFilename
     * @param size
     * @param contentType
     * @param fid
     */
    public void saveFile(InputStream inputStream, String originalFilename, long size, String contentType, Integer fid) {
        Document document = new Document();
        String exeName = "";
        if(originalFilename.lastIndexOf(".") != -1){
            exeName = originalFilename.substring(originalFilename.lastIndexOf("."));
        }

        String newFilename = UUID.randomUUID() + exeName;
        try {
            FileOutputStream fileOutputStream = new FileOutputStream(new File(savePath,newFilename));
            IOUtils.copy(inputStream,fileOutputStream);

            fileOutputStream.flush();
            fileOutputStream.close();
            inputStream.close();
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException();
        }
        document.setCreateuser(ShiroUtil.getCurrentUserRealname());
        document.setSize(FileUtils.byteCountToDisplaySize(size));
        document.setFid(fid);
        document.setContenttype(contentType);
        document.setFilename(newFilename);
        document.setName(originalFilename);

        documentMapper.save(document);

    }

    public Document findAllById(Integer id) {
        return documentMapper.findById(id);
    }
}
