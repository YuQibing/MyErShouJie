package com.yuqibing.java.service;
import org.apache.commons.io.FileUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.mortbay.util.StringUtil;
import org.springframework.web.multipart.MultipartFile;

import java.awt.*;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.sql.Date;
import java.util.Properties;
import java.util.UUID;

/**
 * Created by yuqibing on 31/01/2017.
 */
public class pictureUploadService {

    public  String getUniqueFileName() {
        String str = UUID.randomUUID().toString();
        return str.replace("-", "");
    }
    JSONArray imageArray = new JSONArray();

    public boolean saveFile(MultipartFile file, JSONObject images) throws IOException {
        String fileName = file.getOriginalFilename();
        String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
        String allowSuffixs = "gif,jpg,jpeg,bmp,png,ico";
        if (allowSuffixs.indexOf(suffix) == -1) {
            //params.put("resultStr", "not support the file type!");
            return false;
        }
        Properties config = new Properties();
        config.load(this.getClass().getClassLoader().getResourceAsStream("config.properties"));
        String urlPath = config.getProperty("urlRoot");
        String localPath = config.getProperty("localhostRoot");

        String uri = File.separator;

        File dir = new File(localPath + uri);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        String newFileName = getUniqueFileName();
        File f = new File(dir.getPath() + File.separator + newFileName + "." + suffix);
        System.out.println("--------newFilePath--------"+f.getPath());

        FileUtils.copyInputStreamToFile(file.getInputStream(), f);

        //创建Picture对象


//        Picture pic = new Picture();
//        pic.setLocalPath(f.getAbsolutePath());
//        pic.setName(f.getName());
//
//        pic.setUrl(urlPath + uri.replace("\\", "/")  + newFileName + "." + suffix);
        String Url = (urlPath + uri.replace("\\", "/")  + newFileName + "." + suffix);


        JSONObject image = new JSONObject();

        image.put("ImageUrl", Url);
        imageArray.put(image);
        images.put("ImageUrls",imageArray);




        return true;

    }

    public  boolean upload(MultipartFile[] files, JSONObject params)throws Exception {
//        String fileName = file.getOriginalFilename();
//        String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
//        String allowSuffixs = "gif,jpg,jpeg,bmp,png,ico";
//        if (allowSuffixs.indexOf(suffix) == -1) {
//            params.put("resultStr", "not support the file type!");
//            return false;
//        }
//
//        Properties config = new Properties();
//        config.load(this.getClass().getClassLoader().getResourceAsStream("config.properties"));
//        String urlPath = config.getProperty("urlRoot");
//        String localPath = config.getProperty("localhostRoot");
//
//        String uri = File.separator;
//
//        File dir = new File(localPath + uri);
//        if (!dir.exists()) {
//            dir.mkdirs();
//        }
//
//        String newFileName = getUniqueFileName();
//        File f = new File(dir.getPath() + File.separator + newFileName + "." + suffix);
//        System.out.println("--------newFilePath--------"+f.getPath());
//
//        FileUtils.copyInputStreamToFile(file.getInputStream(), f);
//
//        //创建Picture对象
//
//
//        Picture pic = new Picture();
//        pic.setLocalPath(f.getAbsolutePath());
//        pic.setName(f.getName());
//        pic.setUrl(urlPath + uri.replace("\\", "/")  + newFileName + "." + suffix);
//          params.put("resultStr", pic.getUrl());


        //插入到数据库



        if(files!=null&& files.length>0){
            for(int i = 0;i<files.length;i++){
                MultipartFile file = files[i];
                saveFile(file, params);

            }

        }
        return true;
    }

    }




