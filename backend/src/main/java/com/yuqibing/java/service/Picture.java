package com.yuqibing.java.service;

/**
 * Created by yuqibing on 31/01/2017.
 */
public class Picture {
    private String localPath;
    private String name;
    private String url;

    public void setLocalPath(String localPath) {
        this.localPath = localPath;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setUrl(String url) {
        this.url = url;

    }

    public String getUrl() {
        return url;
    }

    public String getLocalPath(){
        return localPath;
    }

    public String getName(){
        return name;
    }
}
