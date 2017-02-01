//
//  ClassTraffic.swift
//  MyErShouJie
//
//  Created by bingbing on 16/12/25.
//  Copyright © 2016年 yuqibing. All rights reserved.
//

import UIKit

class ClassTraffic: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "交通工具"
        let layout = UICollectionViewFlowLayout()
        collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), collectionViewLayout: layout)
        layout.itemSize = CGSize(width: (ScreenWidth-10)/2, height: 250)
        collection?.register(ClassTrafficCollectionViewCell.self, forCellWithReuseIdentifier: "traffic")
        
        collection?.delegate = self
        collection?.dataSource = self
        self.view.addSubview(collection!)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "traffic", for: indexPath) as! ClassTrafficCollectionViewCell
        
        cell.layer.borderWidth = 0.3
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.titleLabel!.text = "hello"
        cell.priceLabel!.text = "￥ 111"
        cell.readLabel!.text = "💗 520"
        return cell
    }
    
}
