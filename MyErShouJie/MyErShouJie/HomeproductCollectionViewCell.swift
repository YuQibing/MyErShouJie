//
//  HomeproductCollectionViewCell.swift
//  MyErShouJie
//
//  Created by bingbing on 16/12/25.
//  Copyright © 2016年 yuqibing. All rights reserved.
//

import UIKit

class HomeproductCollectionViewCell: UICollectionViewCell {
    let width = UIScreen.main.bounds.size.width
    private var customConstraints: [NSLayoutConstraint] = []
    
    public lazy var imageView: UIImageView = {
    
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: (UIScreen.main.bounds.width-10)/2, height: 200)
        return imageView
    }()
    
    public lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        return titleLabel
    }()
    
    public lazy var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.textAlignment = NSTextAlignment.right
        return priceLabel
    }()
    
    public lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        return descriptionLabel
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.setNeedsUpdateConstraints()
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        self.addSubview(priceLabel)
        self.addSubview(descriptionLabel)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        let views = [
            "imageView": imageView,
            "titleLabel": titleLabel,
            "priceLabel": priceLabel,
            "descriptionLabel": descriptionLabel
        ] as [String : Any]
        
        let metrics = [
            "descriptionLabelWidth": Float((UIScreen.main.bounds.width-10)/2)
        ]
        print("==========titlelabelwidth", Float((UIScreen.main.bounds.width-10)/2) )
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel(100)]", options:NSLayoutFormatOptions.alignAllTrailing, metrics: nil, views: views))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:[priceLabel]-|", options:NSLayoutFormatOptions.alignAllTrailing, metrics: nil, views: views))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|-(205)-[priceLabel]-[descriptionLabel]-|", options:NSLayoutFormatOptions.alignAllLeading, metrics: nil, views: views))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|-(205)-[titleLabel]", options:NSLayoutFormatOptions.alignAllTop, metrics: metrics, views: views))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-[descriptionLabel]-|", options:NSLayoutFormatOptions.alignAllTop, metrics: nil, views: views))
        NSLayoutConstraint.activate(customConstraints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
