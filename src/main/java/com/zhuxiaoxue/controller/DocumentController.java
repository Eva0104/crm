package com.zhuxiaoxue.controller;

import com.zhuxiaoxue.exception.NotFoundException;
import com.zhuxiaoxue.pojo.Document;
import com.zhuxiaoxue.service.DocumentService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.inject.Inject;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/doc")
public class DocumentController {

    @Inject
    private DocumentService documentService;

    @Value("${imagePath}")
    private String savePath;

    @RequestMapping(method = RequestMethod.GET)
    public String list(Model model,
                       @RequestParam(required = false,defaultValue = "0")Integer fid){

        List<Document> documentList = documentService.findAllByfid(fid);
        model.addAttribute("fid",fid);
        model.addAttribute("documentList",documentList);
        return "/document/list";
    }

    /**
     * 新建文件夹
     * @param name
     * @param fid
     * @return
     */
    @RequestMapping(value = "/dir/new",method = RequestMethod.POST)
    public String addDir(String name,Integer fid){
        documentService.addDir(name,fid);
        return "redirect:/doc?fid="+fid;
    }

    /**
     * 上传文件
     * @param file
     * @param fid
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/file/upload",method = RequestMethod.POST)
    @ResponseBody
    public String saveFile(MultipartFile file,Integer fid) throws IOException {
        if(file.isEmpty()){
            throw new NotFoundException();
        }else{
            documentService.saveFile(file.getInputStream(),file.getOriginalFilename(),file.getSize(),file.getContentType(),fid);
        }
        return "success";
    }

    /**
     * 下载文件
     * @param id
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/download/{id:\\d+}",method = RequestMethod.GET)
    public ResponseEntity<InputStreamResource> downloadFile(@PathVariable Integer id) throws IOException {
        Document document = documentService.findAllById(id);
        if(document == null){
            throw new NotFoundException();
        }

        File file = new File(savePath,document.getFilename());
        if(!file.exists()){
            throw new NotFoundException();
        }

        FileInputStream fileInputStream = new FileInputStream(file);

        String fileName = document.getName();
        fileName = new String(fileName.getBytes("UTF-8"),"ISO8859-1");

        return ResponseEntity
                .ok()
                .contentType(MediaType.parseMediaType(document.getContenttype()))
                .contentLength(file.length())
                .header("Content-Disposition","attachment;filename=\""+fileName+"\"")
                .body(new InputStreamResource(fileInputStream));
    }

//    /**
//     * 返回上一级
//     * @param id
//     * @param model
//     * @return
//     */
//    @RequestMapping(value = "/back/{id:\\d+}",method = RequestMethod.GET)
//    public String goBack(@PathVariable Integer id,Model model){
//
//        Document document = documentService.findAllById(id);
//
//        Integer fid = document.getFid();
//
//        model.addAttribute("fid",fid);
//        return "redirect:/doc";
//
//    }

}
