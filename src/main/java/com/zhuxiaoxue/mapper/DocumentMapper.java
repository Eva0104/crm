package com.zhuxiaoxue.mapper;

import com.zhuxiaoxue.pojo.Document;

import java.util.List;

/**
 * Created by Eric on 2016/7/13.
 */
public interface DocumentMapper {


    List<Document> findAllByfid(Integer fid);

    void save(Document document);

    Document findById(Integer id);
}
