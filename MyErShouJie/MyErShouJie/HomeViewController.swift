//
//  HomeViewController.swift
//  MyErShouJie
//
//  Created by bingbing on 16/11/7.
//  Copyright © 2016年 yuqibing. All rights reserved.
//

import UIKit



class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        
        collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), collectionViewLayout: layout)
        
        collection.register(HomeCycleViewCell.self, forCellWithReuseIdentifier: "page")
        collection.register(HomeproductCollectionViewCell.self, forCellWithReuseIdentifier: "product")
        collection.dataSource = self
        collection.delegate = self
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width-30)/2, height: 250)
        
        self.view.addSubview(collection!)
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "page", for: indexPath) as! HomeCycleViewCell
            //cell.label?.text = "hello"
            return cell
        }else{
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "product", for: indexPath) as! HomeproductCollectionViewCell
            cell.layer.borderWidth = 0.3
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.titleLabel!.text = "hello"
            cell.priceLabel!.text = "￥ 111"
            cell.readLabel!.text = "💗 520"
            return cell
        }
    }
    
    
    
    
}
    
   
    
    
    
    





    
    


     

