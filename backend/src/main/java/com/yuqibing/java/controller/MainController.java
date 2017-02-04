package com.yuqibing.java.controller;

import com.yuqibing.java.entity.Product;
import com.yuqibing.java.service.ProductService;
import com.yuqibing.java.service.pictureUploadService;
import org.json.simple.JSONObject;
import org.json.JSONArray;
import org.mortbay.util.ajax.JSON;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

/**
 * Created by yuqibing on 25/01/2017.
 */
@Controller
@RequestMapping("/")
public class MainController {
    @Autowired
    private ProductService productService;
    @RequestMapping(value = "/json", method = RequestMethod.GET)
    @ResponseBody

    public List<Product> json(){
        System.out.println("-------------MainController--------");
        return productService.getAllData();
    }

    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    @ResponseBody
    public String upload(@RequestParam(value = "title") String title,
                         @RequestParam(value = "type") int type,
                         @RequestParam(value = "price") double price,
                         @RequestParam(value = "img")MultipartFile[] files,
                         @RequestParam(value = "description") String description,
                         @RequestParam(value = "longitude", required = false, defaultValue = "0.0") double longitude,
                         @RequestParam(value = "latitude", required = false, defaultValue = "0.0") double latitude,
                         HttpServletResponse response) {


        JSONObject result = new JSONObject();
        JSONObject image_urls = new JSONObject();

        Boolean returnVale = false;

        pictureUploadService picservice = new pictureUploadService();

        Product product = new Product();

        //FileUpLoad
        try {
            returnVale = picservice.uploadFiles(files, image_urls);
        } catch (Exception e) {
            result.put("mess", "调用失败");
            returnVale = false;
            e.printStackTrace();
        }

        product.setTitle(title);
        product.setType(type);
        product.setImage_urls(image_urls.toString());
        product.setDescription(description);
        product.setLiked(0);
        product.setTime(new Date());
        product.setPrice(price);
        product.setLongitude(longitude);
        product.setLatitude(latitude);

        //String image_urlss = image_urls.toString();
        result.put("return", returnVale);
        result.put("image_urls",image_urls);
        System.out.println("Product="+product);
        //Insert data to database
        InsertdatatoDB(product);



//        response.setContentType("text/html;charset=UTF-8");

  //      response.setHeader("Access-Control-Allow-Origin","*");

        return result.toString();
    }

    private int InsertdatatoDB(Product product){
        pictureUploadService pictureservice = new pictureUploadService();

        System.out.println("===========insertData========");


        return productService.saveProducts(product);

    }

}


