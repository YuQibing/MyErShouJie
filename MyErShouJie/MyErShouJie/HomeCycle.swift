//
//  HomeCycle.swift
//  MyErShouJie
//
//  Created by bingbing on 16/12/20.
//  Copyright © 2016年 yuqibing. All rights reserved.
//

import UIKit

class HomeCycle: UICollectionViewCell {
    var width = UIScreen.main.bounds.width
    var label: UILabel?
    
    override init (frame: CGRect){
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

extension HomeCycle {
    
    fileprivate func setupUI(){
        
        let cycleView = HomeCycleScrollView(frame: CGRect(x: 0, y: 0, width: width, height: 200))
        
        contentView.addSubview(cycleView)
        
        
    }
    
}
