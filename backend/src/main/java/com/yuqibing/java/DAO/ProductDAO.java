package com.yuqibing.java.DAO;

import com.yuqibing.java.entity.Product;
import java.util.List;

/**
 * Created by yuqibing on 25/01/2017.
 */
public interface ProductDAO {
    public int save(Product product);
    public List<Product> findAll();
    public List<Product> qureyProduct(String queryString);
}
