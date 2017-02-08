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

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    var productArray: Array<Product> = []
    var collectionView: UICollectionView!
    var refreshControl = UIRefreshControl()
    
    
    convenience init(){
        self.init(nibName:nil, bundle:nil)
        
        getDataFromServer()            
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        
        refreshControl.addTarget(self, action: #selector(HomeViewController.refreshData), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "刷新商品")
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), collectionViewLayout: layout)
        
        collectionView.register(HomeCycleViewCell.self, forCellWithReuseIdentifier: "page")
        collectionView.register(HomeproductCollectionViewCell.self, forCellWithReuseIdentifier: "product")
        collectionView.dataSource = self
        collectionView.delegate = self
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width-30)/2, height: 250)
        
        self.view.addSubview(refreshControl)
        self.view.addSubview(collectionView!)
        
        refreshData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshData(){
        self.collectionView.reloadData()
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    
    func  collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return self.productArray.count
        }
    }
    
    func getDataFromServer(){
        
        let serverAPI = ServerAPI()
        print("-----getDataFromServer------")
        serverAPI.list(){ jsonReturn in
            
            print("JSON COUNT = ", jsonReturn.count)
            //print("JSONVALUE = ", jsonReturn)
            
            for index in 0...jsonReturn.count-1{
                let product = Product()
                product.id = jsonReturn[index]["id"].int
                product.descriptions = jsonReturn[index]["descriptions"].string
                product.image_urls = jsonReturn[index]["image_urls"].arrayValue
                product.latitude = jsonReturn[index]["latitude"].double
                product.longitude = jsonReturn[index]["longitude"].double
                product.liked = jsonReturn[index]["liked"].int
                product.price = jsonReturn[index]["price"].double
                product.time = jsonReturn[index]["time"].string
                self.productArray.append(product)
            }
            print("productArrayCount = ",self.productArray.count)
            
        }
    }
    
    
    
    
    
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "page", for: indexPath) as! HomeCycleViewCell
            //cell.label?.text = "hello"
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "product", for: indexPath) as! HomeproductCollectionViewCell
            print("-------collectionView cell text--------")
            cell.layer.borderWidth = 0.3
            cell.layer.borderColor = UIColor.lightGray.cgColor
            
            cell.titleLabel!.text = productArray[indexPath.row].title
            cell.priceLabel!.text = String(describing: productArray[indexPath.row].price)
            cell.readLabel!.text = String(describing: productArray[indexPath.row].liked)
            return cell
        }
    }
    
    
    
    
}
    
   
    
    
    
    





    
    


     

