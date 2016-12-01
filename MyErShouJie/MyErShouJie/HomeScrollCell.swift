//
//  HomeScrollCell.swift
//  MyErShouJie
//
//  Created by bingbing on 16/11/19.
//  Copyright © 2016年 yuqibing. All rights reserved.
//

import UIKit

class HomeScrollCell: UITableViewCell {
    //类的初始化
    override init (style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.white
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate let headView: HomeHeadCollectionView = HomeHeadCollectionView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenWidth/2))
}

extension HomeScrollCell {
    
    fileprivate func setupUI(){
        contentView.addSubview(headView)
    }
}
