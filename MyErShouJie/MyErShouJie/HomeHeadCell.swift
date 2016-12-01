//
//  HomeHeadCell.swift
//  MyErShouJie
//
//  Created by bingbing on 16/11/19.
//  Copyright © 2016年 yuqibing. All rights reserved.
//

import UIKit
import SnapKit

let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height

class HomeHeadCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.red
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }

}
extension HomeHeadCell{
    fileprivate func setupUI(){
        
        let cycleView = HomeCycleScrollView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 200))
        contentView.addSubview(cycleView)
        
    }
}
