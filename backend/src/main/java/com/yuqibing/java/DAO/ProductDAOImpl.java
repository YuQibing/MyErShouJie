package com.yuqibing.java.DAO;

import com.yuqibing.java.entity.Product;
import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by yuqibing on 25/01/2017.
 */
@Repository
public class ProductDAOImpl implements ProductDAO{

    @Autowired
    private SessionFactory sessionFactory;

    public int save(Product product) {
        return (Integer) sessionFactory.getCurrentSession().save(product);
    }

    public List<Product> findAll() {
        Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Product.class);
        return criteria.list();
    }
}
