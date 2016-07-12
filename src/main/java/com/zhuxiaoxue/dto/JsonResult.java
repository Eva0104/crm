package com.zhuxiaoxue.dto;

import com.fasterxml.jackson.annotation.JsonInclude;

@JsonInclude(JsonInclude.Include.NON_NULL)
public class JsonResult {

    private static final String SUCCESS="success";
    private static final String ERROR="error";

    private String state;
    private String message;
    private Object data;

    public JsonResult(Object data) {
        this(SUCCESS,data);
    }

    public JsonResult(String message) {
        this(ERROR,message);
    }

    public JsonResult(String state, String message) {
        this.state = state;
        this.message = message;
    }

    public JsonResult(String state, Object data) {
        this.state = state;
        this.data = data;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}
