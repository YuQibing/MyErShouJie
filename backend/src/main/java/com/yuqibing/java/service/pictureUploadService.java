package com.yuqibing.java.service;
import com.yuqibing.java.entity.Product;
import org.apache.commons.io.FileUtils;

import org.json.JSONArray;
import org.mortbay.util.StringUtil;
import org.mortbay.util.ajax.JSON;
import org.springframework.web.multipart.MultipartFile;
import org.json.simple.JSONObject;


import java.awt.*;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.sql.Date;
import java.util.*;
import java.util.List;

/**
 * Created by yuqibing on 31/01/2017.
 */
public class pictureUploadService {

    public  boolean uploadFiles(MultipartFile[] imgs, JSONObject image)throws Exception {

        if(imgs!=null && imgs.length>0) {
            for(int i=0;i<imgs.length;i++) {
                MultipartFile file = imgs[i];
                uploadOneFile(file, image);
            }
        }
        return true;
    }

    public  String getUniqueFileName() {
        String str = UUID.randomUUID().toString();
        return str.replace("-", "");
    }
    JSONArray imageArray = new JSONArray();

    public boolean uploadOneFile(MultipartFile file, JSONObject images) throws IOException {
        String fileName = file.getOriginalFilename();
        String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
        String allowSuffixs = "gif,jpg,jpeg,bmp,png,ico";
        if (allowSuffixs.indexOf(suffix) == -1) {
            images.put("resultStr", "not support the file type!");
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
        String Url = (urlPath + uri.replace("\\", "/")  + newFileName + "." + suffix);

        JSONObject image = new JSONObject();

        image.put("ImageUrl", Url);
        imageArray.put(image);
        images.put("ImageUrls",imageArray);
        System.out.println(imageArray);

        return true;

    }


    }




