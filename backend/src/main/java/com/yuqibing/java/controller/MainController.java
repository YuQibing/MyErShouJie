package com.yuqibing.java.controller;

import com.yuqibing.java.entity.Product;
import com.yuqibing.java.service.ProductService;
import com.yuqibing.java.service.pictureUploadService;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;

/**
 * Created by yuqibing on 25/01/2017.
 */
@Controller
@RequestMapping("/")
public class MainController {

    @Autowired
    private ProductService productService;



    @RequestMapping(value = "/insertData", method = RequestMethod.POST)
    public String productadd(){
        Product product = new Product();
        product.setTitle("===+++---");
        productService.saveProducts(product);
        return "index";
    }

    @RequestMapping(value = "/json", method = RequestMethod.GET)
    @ResponseBody

    public List<Product> json(){
        System.out.println("-------------MainController--------");
        return productService.getAllData();
    }


    @RequestMapping(value = "/uploadFile", method = RequestMethod.POST)
    @ResponseBody



    public String uploadImg(@RequestParam(value = "img")MultipartFile[] img, HttpServletResponse response) {


        JSONObject result = new JSONObject();
        boolean flag = true;
        pictureUploadService picservice = new pictureUploadService();

        try {
            flag = picservice.upload(img, result);
        } catch (Exception e) {
            result.put("mess", "调用失败");
            flag = false;
            e.printStackTrace();
        }
        result.put("flag", flag);

        response.setContentType("text/html;charset=UTF-8");

        response.setHeader("Access-Control-Allow-Origin","*");

        return result.toString();
    }

//    public String uploadImg(@RequestParam(value = "img")MultipartFile img) throws IOException {
//
//
//        File file = new File ( "/dataimages/1.jpg");
//
//        System.out.println("-------------uplaadImg-----------"+file.getAbsolutePath());
//        try {
//            FileUtils.copyInputStreamToFile(img.getInputStream(), file);
//
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return "uploadimg";
//    }


}











//    public String add(){
//        List<User> userArray = new ArrayList<User>();
//        User user =new User();
//        user.setUsername("+++");
//        userArray.add(user);
//        user = new User();
//        user.setUsername("white");
//        userArray.add(user);
//        userService.saveUsers(userArray);
//        return "index";
//
//    }



//    @RequestMapping("")
//    public String home(){
//        System.out.println("-------------MainController index----------");
//        List<User> us = new ArrayList<User>();
//        User u = new User();
//        u.setUsername("amy");
//        us.add(u);
//        u = new User();
//        u.setUsername("alex");
//        us.add(u);
//        userService.saveUsers(us);
//        return "index";
//    }

//    @RequestMapping("")
//    public String index(){
//        System.out.println("-------------MainController index--------");
//
//        return "index";
//    }

//        Map<String, String> result = new HashMap<String, String>();
//        result.put("MarK", "hello");
//        result.put("Ken", "Hehe");
//        result.put("Fowafolo", "fool");

//public class MainController {
//
//
//
//    @RequestMapping(value = "{name}/{id}", method = RequestMethod.GET)
//    public @ResponseBody hop getShopInJSON(@PathVariable String name, @PathVariable String id) {
//        System.out.print("aaa");
//        hop shop = new hop();
//        shop.setName(name);
//        shop.setStaffName(new String[]{"1111", "2222"});
//        shop.setID(id);
//
//        return shop;
//
//
//    }
//
//
//}