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
    
    var product = Product()
    var productArray: Array<Product> = []
    var collectionView: UICollectionView!
    
    convenience init(){
        self.init(nibName:nil, bundle:nil)
        self.getDataFromServer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), collectionViewLayout: layout)
        
        collectionView.register(HomeCycleViewCell.self, forCellWithReuseIdentifier: "page")
        collectionView.register(HomeproductCollectionViewCell.self, forCellWithReuseIdentifier: "product")
        collectionView.dataSource = self
        collectionView.delegate = self
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width-30)/2, height: 250)
        
        self.view.addSubview(collectionView!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return 50
        }
    }
    
    func getDataFromServer(){
        
        var serverAPI = ServerAPI()
        print("-----getDataFromServer------")
        serverAPI.list()
        
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
            
            cell.titleLabel!.text = "hello"
            cell.priceLabel!.text = "44"
            cell.readLabel!.text = "8"
            return cell
        }
    }
    
    
    
    
}
    
   
    
    
    
    





    
    


     

