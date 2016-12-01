//
//  HomeTextScrollCell.swift
//  MyErShouJie
//
//  Created by bingbing on 16/11/21.
//  Copyright © 2016年 yuqibing. All rights reserved.
//

import UIKit
import SnapKit

class HomeTextScrollCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //控件
    fileprivate var textLabel:UILabel?
    //公共属性
    public var textArray:[String]?
    public var indexPath:IndexPath? {
        didSet{
            
            
            textLabel?.text = textArray?[(indexPath?.item)!]
            
        }
        
    }
    
    
}
extension HomeTextScrollCell {
    
    fileprivate func setupUI(){
        
        
        textLabel = UILabel(frame: bounds)
        textLabel?.layer.masksToBounds = true
        textLabel?.backgroundColor = UIColor.yellow
        contentView.addSubview(textLabel!)
        
        textLabel?.snp.makeConstraints({ (make) in
            
            make.center.equalTo(self)
        })
    }
    
}
