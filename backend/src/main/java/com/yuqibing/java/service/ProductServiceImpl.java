package com.yuqibing.java.service;

import com.yuqibing.java.DAO.ProductDAO;
import com.yuqibing.java.entity.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by yuqibing on 25/01/2017.
 */
@Service("userService")
@Transactional
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductDAO productDAO;
    public void saveProducts(Product product) {

        productDAO.save(product);

    }


    //    private UserDAO userDAO;
//    public void saveUsers(List<User> userArray) {
//        for (User user : userArray) {
//            userDAO.save(user);
//        }
//
//    }
    public List<Product> getAllData() {
        return productDAO.findAll();
    }
}





//    public List<String> getAllUsernames(){
//        List<String> users = new ArrayList<String>();
//        users.add("mark");
//        users.add("yuqibing");
//        users.add("hello");
//        return users;
//    }

