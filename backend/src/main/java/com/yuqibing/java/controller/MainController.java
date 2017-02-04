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
    public static final String DEFAULT_MAX_PRICE = "99999999.0";
    public static final String DEFAULT_MIN_PRICE = "0.0";
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody

    public List<Product> list(@RequestParam(value = "searchKeyWords") String searchKeyWords,
                              @RequestParam(value = "type", required = false, defaultValue = "0") int type,
                              @RequestParam(value = "maxPrice", required = false, defaultValue = DEFAULT_MAX_PRICE) double maxPrice,
                              @RequestParam(value = "minPrice", required = false, defaultValue = DEFAULT_MIN_PRICE) double minPrice,
                              @RequestParam(value = "sinceTime", required = false, defaultValue = "0") int sinceTime,
                              @RequestParam(value = "count",required = false,defaultValue = "20") int count,
                              @RequestParam(value = "page",required = false,defaultValue = "1") int page) {
        System.out.println("-------------ListAPI---------");
        String queryString = new String();
        Boolean queryStringhasWhere = false;

        if(searchKeyWords.equalsIgnoreCase("*") ) {
            queryString = "from productdetail";
        } else {
            queryString = "from productdetail where (title like '%"+searchKeyWords+"%'" +
                          " or description like '%"+searchKeyWords+"%')";
            queryStringhasWhere = true;
        }

        if(type != 0){
            if (queryStringhasWhere) {
                queryString = queryString+" and type="+type;
            } else {
                queryString = queryString+" where type="+type;
            }
            queryStringhasWhere = true;
        }

        if(Double.parseDouble(DEFAULT_MAX_PRICE)!=maxPrice){
            if (queryStringhasWhere) {
                queryString = queryString+" and price<="+maxPrice;
            } else {
                queryString = queryString+" where price<="+maxPrice;
            }
            queryStringhasWhere = true;
        }

        if(Double.parseDouble(DEFAULT_MIN_PRICE)!=minPrice){
            if (queryStringhasWhere) {
                queryString = queryString+" and price>="+minPrice;
            } else {
                queryString = queryString+" where price>="+minPrice;
            }
            queryStringhasWhere = true;
        }


        System.out.println("queryString="+queryString);

        return productService.queryProduct(queryString);
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


