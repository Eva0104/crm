package com.zhuxiaoxue.pojo;

import java.io.Serializable;
import java.sql.Timestamp;

public class SalesLog implements Serializable {

    public static final String TYPE_AUTO = "自动";
    public static final String TYPE_MANUAL = "手动";


    private Integer id;
    private Integer salesid;
    private String context;
    private Timestamp createtime;
    private String type;

    public SalesLog() {
    }

    public SalesLog(Integer salesid, String context, String type) {
        this.salesid = salesid;
        this.context = context;
        this.type = type;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getSalesid() {
        return salesid;
    }

    public void setSalesid(Integer salesid) {
        this.salesid = salesid;
    }

    public String getContext() {
        return context;
    }

    public void setContext(String context) {
        this.context = context;
    }

    public Timestamp getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Timestamp createtime) {
        this.createtime = createtime;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
