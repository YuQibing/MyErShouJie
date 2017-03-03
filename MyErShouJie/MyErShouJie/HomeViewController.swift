//
//  HomeViewController.swift
//  MyErShouJie
//
//  Created by bingbing on 16/11/7.
//  Copyright © 2016年 yuqibing. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MJRefresh
import Haneke

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    var productArray: Array<Product> = []
    var collectionView: UICollectionView!
    let header = MJRefreshNormalHeader()
    
    
    convenience init(){
        self.init(nibName:nil, bundle:nil)
        
        
        getDataFromServer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        
        header.setRefreshingTarget(self, refreshingAction: #selector(HomeViewController.refreshData))
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), collectionViewLayout: layout)
        
        collectionView.register(HomeCycle.self, forCellWithReuseIdentifier: "page")
        collectionView.register(HomeproductCollectionViewCell.self, forCellWithReuseIdentifier: "product")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        
        self.collectionView!.mj_header = header
        self.view.addSubview(collectionView!)
        
    //    refreshData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshData(){
//        if self.collectionView != nil {
//            self.collectionView.reloadData()
        
//        }
        getDataFromServer()
        self.collectionView!.mj_header.endRefreshing()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    
    func  collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
            return self.productArray.count
        }
    }
    
    func getDataFromServer(){
        
        let serverAPI = ServerAPI()
        print("-----getDataFromServer------")
        serverAPI.list() { jsonReturn in
            
            print("JSON COUNT = ", jsonReturn.count)
            //print("JSONVALUE = ", jsonReturn)
            
            for index in 0...jsonReturn.count-1 {
                let product = Product()
                var oneProductJson = jsonReturn[index]
                var imageUrlsJsonArray: Array<Any>
                var imageUrlsDic = [String: String]()
                var imageUrlsArray = [String]()
                let imgUrlsText = (oneProductJson["image_urls"].string)?
                    .data(using: String.Encoding.utf8)
                do {
                    let imgUrlsJson = try JSONSerialization.jsonObject(with: imgUrlsText!, options: .mutableContainers)
                    if let imageUrlsJson = imgUrlsJson as? [String:Any] {
                        
                        print("imageUrlsJson = ", imageUrlsJson)
                        imageUrlsJsonArray = imageUrlsJson["ImageUrls"] as! [Any]
                        
                        for imageUrlsIndex in 0...imageUrlsJsonArray.count-1 {
                            imageUrlsDic = imageUrlsJsonArray[imageUrlsIndex] as! [String : String]
                            imageUrlsArray.append(imageUrlsDic["ImageUrl"]!)
                        }
                        print("----------------imageUrlsArray Values = ", imageUrlsDic["ImageUrl"]!)
                    }
                } catch {
                    print(error.localizedDescription)
                }
                
                
                product.id = oneProductJson["id"].int
                product.title = oneProductJson["title"].string
                product.type = oneProductJson["type"].int
                product.descriptions = oneProductJson["description"].string
                product.image_urls = imageUrlsArray
                product.latitude = oneProductJson["latitude"].double
                product.longitude = oneProductJson["longitude"].double
                product.liked = oneProductJson["liked"].int
                product.price = oneProductJson["price"].double
                product.time = oneProductJson["time"].string
                self.productArray.append(product)
                
                print("index=", index)
//                print("Product.image_urls =", product.image_urls)
//                print("jsonReturn =", oneProductJson["image_urls"].string)
            }
            print("productArrayCount = ", self.productArray.count)
            self.collectionView.reloadData()
        }
    }
    
 
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            return CGSize(width: CGFloat(collectionView.frame.size.width ), height: CGFloat(205))
          
            
        } else {
            return CGSize(width: CGFloat((collectionView.frame.size.width-10)/2), height: CGFloat(255))
            
        }
        
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "page", for: indexPath) as! HomeCycle
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "product", for: indexPath) as! HomeproductCollectionViewCell
            print("-------collectionView cell text--------")
            cell.layer.borderWidth = 0.3
            cell.layer.borderColor = UIColor.lightGray.cgColor
            
            var product = Product()
            product = productArray[indexPath.row]
            let imgStr = (product.image_urls?[0])!
            let urlimage = URL(string: baseUrl + imgStr)
            cell.imageView.hnk_setImage(from: urlimage)
            cell.titleLabel.text = product.title
            cell.priceLabel.text = String(describing: (product.price)!)
            cell.descriptionLabel.text = product.descriptions
            print("cell.titleLabel.text", cell.titleLabel.text!)
            
            return cell
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        var product = Product()
//        product = productArray[indexPath.row]
//        
//        let productDetail = ProductDetailsController()
//        productDetail.hidesBottomBarWhenPushed = true
//        self.navigationController?.pushViewController(productDetail, animated: true)
//        
//        productDetail.productTitle = product.title!
//        productDetail.productPrice = product.price!
//        productDetail.productDescription = product.descriptions!
//        productDetail.imagesUrl = product.image_urls!
//        print("indexpath row = ", product.descriptions!)
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var product = Product()
        product = productArray[indexPath.row]
        
        let productWebView = ProductWebViewController()
        productWebView.setProductDetail(title: product.title!, description: product.descriptions!, imageUrls: product.image_urls!, price: String(describing: product.price!))
        productWebView.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(productWebView, animated: true)
    }
}
    
   
    
    
    
    





    
    


     

