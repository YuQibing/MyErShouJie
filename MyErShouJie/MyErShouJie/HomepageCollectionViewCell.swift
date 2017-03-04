//
//  HomepageCollectionViewCell.swift
//  MyErShouJie
//
//  Created by bingbing on 16/12/25.
//  Copyright © 2016年 yuqibing. All rights reserved.
//

import UIKit

class HomepageCollectionViewCell: UICollectionViewCell {
    var label: UILabel?
    
    override init (frame: CGRect){
        super.init(frame: frame)
        label = UILabel(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 200))
        label?.backgroundColor = UIColor.white
        label?.font = UIFont.boldSystemFont(ofSize: 16.0)
        label?.textColor = UIColor.blue
        self.addSubview(label!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
