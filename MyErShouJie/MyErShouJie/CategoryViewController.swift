//
//  ClassBook.swift
//  MyErShouJie
//
//  Created by bingbing on 16/12/25.
//  Copyright © 2016年 yuqibing. All rights reserved.
//

import UIKit
import MJRefresh


class CategoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var collection: UICollectionView!
    var productArray: Array<Product> = []
    let header = MJRefreshNormalHeader()
    let serverAPI = ServerAPI()
    var type = Int()
    
    
    convenience init(){
        self.init(nibName:nil, bundle:nil)
        //getDataFromServer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        header.setRefreshingTarget(self, refreshingAction: #selector(CategoryViewController.refreshData))
        collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), collectionViewLayout: layout)
        layout.itemSize = CGSize(width: (ScreenWidth-10)/2, height: 250)
        collection?.register(HomeproductCollectionViewCell.self, forCellWithReuseIdentifier: "category")
        collection.backgroundColor = UIColor.white
        collection?.delegate = self
        collection?.dataSource = self
        self.view.addSubview(collection!)
        self.collection!.mj_header = header
    }
    
    
    func refreshData(){
        if self.collection != nil {
            self.collection.reloadData()
            self.collection!.mj_header.endRefreshing()
        }
    }
    
    func getDataFromServer(){
        let serverAPI = ServerAPI()
        let alertCategory = Alert()
        print("-----getDataFromServer------")
        serverAPI.listByType(type: type) { jsonReturn in
            
            print("JSON COUNT = ", jsonReturn.count)
            //print("JSONVALUE = ", jsonReturn)
            if  jsonReturn.count == 0 {
                alertCategory.alertView(message: "该类物品暂时还没有", okActionTitle: "好的", fromViewController: self, dismissParentViewController: false)

            } else {
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
                        self.refreshData()
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
                self.refreshData()
            }
        }
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "category", for: indexPath) as! HomeproductCollectionViewCell
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
        cell.descriptionLabel.text = String(describing: (product.descriptions)!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat((collectionView.frame.size.width-10)/2), height: CGFloat(255))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var product = Product()
        product = productArray[indexPath.row]
        let productWebView = ProductWebViewController()
        productWebView.setProductDetail(title: product.title!, description: product.descriptions!, imageUrls: product.image_urls!, price: String(describing: product.price!))
        productWebView.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(productWebView, animated: true)
    }
    
}
