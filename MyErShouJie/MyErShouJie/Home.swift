//
//  Home.swift
//  MyErShouJie
//
//  Created by bingbing on 16/11/16.
//  Copyright © 2016年 yuqibing. All rights reserved.
//

import UIKit

class Home:UIViewController, UICollectionViewDelegate {
    let width = UIScreen.main .bounds.size.width
    var collection = UICollectionView()
    var dataArr = NSMutableArray()
    var screenObject = UIScreen.main.bounds

    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            let layout = UICollectionViewFlowLayout()
            
            collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: screenObject.width, height: screenObject.height), collectionViewLayout: layout)
            collection.register(Home_view.self, forCellWithReuseIdentifier:"cell")
            collection.delegate = self
            //collection.dataSource = self
        
            collection.backgroundColor = UIColor.white
            layout.itemSize = CGSize(width: (width-30)/2, height: 250)
            self.view.addSubview(collection)
    }
    
        func numberOfSections(collection: UICollectionView) -> Int {
            return 1
        }
        
        private func collectionView(collectionView: UICollectionView, numberOfItemsInSection: Int) -> Int{
            return dataArr.count
        }
        
        private func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: IndexPath) ->UICollectionViewCell{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath as IndexPath) as! Home_view
            cell.layer.borderWidth = 0.3
            cell.layer.borderColor = UIColor.lightGray.cgColor
            return cell
        }
        
        func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
            return UIEdgeInsetsMake(5, 10, 5, 10)
        }
        
        
        
        
        
        // Do any additional setup after loading the view.
    }


