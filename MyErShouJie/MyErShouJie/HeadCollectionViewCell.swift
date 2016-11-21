//
//  HeadCollectionViewCell.swift
//  MyErShouJie
//
//  Created by bingbing on 16/11/20.
//  Copyright © 2016年 yuqibing. All rights reserved.
//

import UIKit
import SnapKit


var item = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16"]
fileprivate var imageArr:[UIImage]! = [UIImage(named:"0")!, UIImage(named:"1")!, UIImage(named:"2")!, UIImage(named:"3")!, UIImage(named:"4")!, UIImage(named:"5")!, UIImage(named:"0")!, UIImage(named:"1")!, UIImage(named:"2")!, UIImage(named:"3")!, UIImage(named:"4")!, UIImage(named:"5")!, UIImage(named:"0")!, UIImage(named:"1")!, UIImage(named:"2")!, UIImage(named:"3")!]
class HeadCollectionViewCell: UICollectionViewCell {
    
    //公共属性
    var indexPath:IndexPath?{
        didSet{
            
            
            imageView.image?.rightSizeImage(image: imageArr[(indexPath?.row)!], Size: imageView.bounds.size, completion: { (image) in
                
                self.imageView.image = image
            })
            //            self.imageView.image = imageArr[(indexPath?.row)!]
            titleLabel.text = item[(indexPath?.row)!]
            
        }
        
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //        prepareData()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //属性
    fileprivate let  imageView = UIImageView(imageName: "1")
    fileprivate let  titleLabel = UILabel(text: "11", textColor: UIColor.black, fontSize: 17, textAlignment: .center, MaxLayoutWidth: 0)
}

extension HeadCollectionViewCell {
    
    fileprivate func setupUI(){
        contentView.backgroundColor = UIColor.white
        addSubview(imageView)
        addSubview(titleLabel)
        
        titleLabel.layer.masksToBounds = true
        titleLabel.backgroundColor = UIColor.white
        
        imageView.snp.makeConstraints {(make) in
            
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(5)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            
            make.centerX.equalTo(imageView)
            make.top.equalTo(imageView.snp.bottom)
        }
        
    }

}
