//
//  UIImageView.swift
//  MyErShouJie
//
//  Created by bingbing on 16/11/20.
//  Copyright © 2016年 yuqibing. All rights reserved.
//

import UIKit

extension UIImageView {
    
    convenience init(imageName:String){
        self.init()
        self.image = UIImage(named: imageName)
        sizeToFit()
    }
}
