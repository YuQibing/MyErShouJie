//
//  UILabel+Extension.swift
//  MyErShouJie
//
//  Created by bingbing on 16/11/20.
//  Copyright © 2016年 yuqibing. All rights reserved.
//

import UIKit


extension UILabel {
    
    convenience init(text:String? = nil,
                     textColor:UIColor = UIColor.darkGray,
                     fontSize:CGFloat,
                     textAlignment:NSTextAlignment = .left,
                     MaxLayoutWidth:CGFloat = UIScreen.main.bounds.width - 40){
        self.init()
        
        self.text = text
        self.preferredMaxLayoutWidth = MaxLayoutWidth
        self.textColor = textColor
        self.textAlignment = textAlignment
        
        self.numberOfLines = 0
        sizeToFit()
        
    }
    
}
