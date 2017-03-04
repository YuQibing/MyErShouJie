//
//  PostPreviewImagesCell.swift
//  MyErShouJie
//
//  Created by bingbing on 21/02/2017.
//  Copyright © 2017 yuqibing. All rights reserved.
//

import UIKit

class PostPreviewImagesCell: UICollectionViewCell {
    var imageView: UIImageView?
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: (ScreenWidth/3) - 20, height: (ScreenWidth/3) - 20))
        imageView?.tag = 1
        self.addSubview(imageView!)        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
