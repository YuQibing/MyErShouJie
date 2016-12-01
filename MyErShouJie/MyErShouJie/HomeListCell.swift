//
//  HomeListCell.swift
//  MyErShouJie
//
//  Created by bingbing on 16/11/19.
//  Copyright © 2016年 yuqibing. All rights reserved.
//

import UIKit

class HomeListCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.yellow
        
        let TextView = HomeTextScrollView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 80))
        
        contentView.addSubview(TextView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
