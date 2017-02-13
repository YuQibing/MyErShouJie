//
//  ClassBookCollectionViewCell.swift
//  MyErShouJie
//
//  Created by bingbing on 16/12/25.
//  Copyright © 2016年 yuqibing. All rights reserved.
//

import UIKit

class ClassBookCollectionViewCell: UICollectionViewCell {
    let width = UIScreen.main.bounds.size.width
    var imgView : UIImageView?
    var titleLabel:UILabel?
    var priceLabel:UILabel?
    var readLabel:UILabel?
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        imgView = UIImageView(frame: CGRect(x: 0, y:-10, width: (width-30)/2, height: 200))
        self.addSubview(imgView!)
        
        titleLabel = UILabel(frame: CGRect(x: 5, y: imgView!.frame.maxY-12, width: (width-40)/2, height: 50))
        titleLabel?.numberOfLines = 0
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 14.0)
        titleLabel?.textColor = UIColor.lightGray
        self.addSubview(titleLabel!)
        
        priceLabel = UILabel(frame: CGRect(x: 5, y: imgView!.frame.maxY-12, width: (width-40)/2/2, height: 20))
        priceLabel?.numberOfLines = 0
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 14.0)
        titleLabel?.textColor = UIColor.lightGray
        self.addSubview(priceLabel!)
        
        readLabel = UILabel(frame: CGRect(x: (width-30)/2/2, y: imgView!.frame.maxY, width: (width-40)/2/2, height: 20))
        readLabel?.numberOfLines = 0
        readLabel?.textAlignment = NSTextAlignment.right
        readLabel?.font = UIFont.boldSystemFont(ofSize: 14.0)
        readLabel?.textColor = UIColor.lightGray
        self.addSubview(readLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
