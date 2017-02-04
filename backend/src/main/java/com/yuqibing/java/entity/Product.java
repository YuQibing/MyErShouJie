package com.yuqibing.java.entity;

import com.sun.xml.internal.fastinfoset.util.CharArray;
import com.sun.xml.internal.ws.policy.privateutil.PolicyUtils;

import org.json.simple.JSONObject;
import org.mortbay.util.ajax.JSON;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.xml.soap.Text;
import java.io.Serializable;
import java.util.Date;
import org.json.JSONArray;

/**
 * Created by yuqibing on 25/01/2017.
 */
@Entity
@Table(name = "productdetail")
public class Product implements Serializable {
    @Id
    @GeneratedValue
    private int id;
    private String title;
    private int type;
    private String image_urls;
    private double price;
    private String description;
    private int liked;
    private Date time;
    private double longitude;
    private double latitude;


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

    public void setType(int type) {this.type = type;}

    public int  getType(){return type;}

    public void setImage_urls(String image_urls){
        this.image_urls = image_urls;
    }

    public String getImage_urls(){
        return image_urls;
    }

    public void setPrice(double price){
        this.price = price;
    }

    public double getPrice(){
        return price;
    }

    public void setDescription(String description){
        this.description = description;
    }

    public String getDescription(){
        return description;
    }

    public void setLiked(int liked){
        this.liked = liked;
    }

    public int getLiked(){
        return liked;
    }

    public void setTime(Date time){
        this.time = time;
    }

    public Date getTime(){
        return time;
    }

    public void setLongitude(double longitude){
        this.longitude = longitude;
    }

    public double getLongitude(){
        return longitude;
    }

    public void setLatitude(double latitude){
        this.latitude = latitude;
    }

    public double getLatitude(){
        return latitude;
    }





}
