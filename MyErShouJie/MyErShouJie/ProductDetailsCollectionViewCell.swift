//
//  ProductDetailsCollectionViewCell.swift
//  MyErShouJie
//
//  Created by bingbing on 28/02/2017.
//  Copyright © 2017 yuqibing. All rights reserved.
//

import UIKit

class ProductDetailsCollectionViewCell: UICollectionViewCell {
    
    var images: UIImageView?
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        
        images = UIImageView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 200))

        self.addSubview(images!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
