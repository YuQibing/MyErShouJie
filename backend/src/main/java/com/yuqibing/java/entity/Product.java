package com.yuqibing.java.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;

/**
 * Created by yuqibing on 25/01/2017.
 */
@Entity
@Table
public class Product implements Serializable {
    @Id
    @GeneratedValue
    private int id;
    private String title;
    private String image_url;
    private String url;
    private float price;
    private int liked;
    private Date time;
    private String location;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getTitle(){
        return  title;
    }




}
