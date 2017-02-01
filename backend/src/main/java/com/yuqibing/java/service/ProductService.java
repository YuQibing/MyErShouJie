package com.yuqibing.java.service;

import com.yuqibing.java.entity.Product;
import java.util.List;

/**
 * Created by yuqibing on 25/01/2017.
 */
public interface ProductService {
    //public List<String> getAllUsernames();

    public void saveProducts(Product product);
    public  List<Product> getAllData();


}
