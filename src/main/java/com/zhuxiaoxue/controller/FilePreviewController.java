package com.zhuxiaoxue.controller;

import com.zhuxiaoxue.exception.NotFoundException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.io.*;

@Controller
public class FilePreviewController {

    @Value("${imagePath}")
    private String imageSavePath;

    /**
     * 从磁盘上读取文件，呈现给客户端
     * @param //response
     * @param filename
     * @throws IOException
     */
    @RequestMapping(value = "/preview/{filename}" ,method = RequestMethod.GET)
//    public void filePreview(@PathVariable String filename, HttpServletResponse response) throws IOException {
//        File file = new File(imageSavePath,filename);
//        if(!file.exists()){
//            throw new NotFoundException();
//        }
//
//        FileInputStream inputStream = new FileInputStream(file);
//        OutputStream outputStream = response.getOutputStream();
//        IOUtils.copy(inputStream,outputStream);
//
//        outputStream.flush();
//        outputStream.close();
//        inputStream.close();
//    }

    public ResponseEntity<InputStreamResource> filePreview(@PathVariable String filename) throws IOException {
        File file = new File(imageSavePath,filename);
        if(!file.exists()){
            throw new NotFoundException();
        }
        FileInputStream inputStream = new FileInputStream(file);

        return ResponseEntity
                .ok()
                .contentType(MediaType.IMAGE_JPEG)
                .body(new InputStreamResource(inputStream));
    }
}
