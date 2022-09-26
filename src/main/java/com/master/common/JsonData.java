package com.master.common;

import lombok.Data;

import java.util.HashMap;
import java.util.Map;

@Data
public class JsonData {
    private boolean ret;
    private String msg;
    private Object data;

    public JsonData(boolean ret) {
        this.ret = ret;
    }

    public static JsonData success(Object obj, String msg) {
        JsonData jsonData = new JsonData(true);
        jsonData.data = obj;
        jsonData.msg = msg;
        return jsonData;
    }

    public static JsonData success(Object obj) {
        JsonData jsonData = new JsonData(true);
        jsonData.data = obj;
        return jsonData;
    }

    public static JsonData success() {
        return new JsonData(true);
    }

    public static JsonData fail(String msg) {
        JsonData jsonData = new JsonData(false);
        jsonData.msg = msg;
        return jsonData;
    }

    public Map<String, Object> toMap() {
        HashMap<String, Object> result = new HashMap<>();
        result.put("ret", ret);
        result.put("msg", msg);
        result.put("data", data);
        return result;
    }
}
