//
//  DefaultCell.swift
//  MyErShouJie
//
//  Created by bingbing on 16/11/19.
//  Copyright © 2016年 yuqibing. All rights reserved.
//

import UIKit
import SnapKit

class DefaultCell: UITableViewCell {

    //公共属性
    public var indexPath:IndexPath?{
        didSet{
            
        }
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.white
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate let iconImage: UIImageView = UIImageView(imageName: "pro")
    
    fileprivate let lb_details = UILabel(text: "於其炳的MacPro", textColor: UIColor.darkGray, fontSize: 17, textAlignment: .left, MaxLayoutWidth: 0)
    //价格
    fileprivate let lb_price = UILabel(text: "¥666", textColor: UIColor.red, fontSize: 14, textAlignment: .left, MaxLayoutWidth: 0)
    //原价
    fileprivate let lb_expiredPrice = UILabel(text: "¥13000", textColor: UIColor.darkGray, fontSize: 14, textAlignment: .left, MaxLayoutWidth: 0)
    
    
}
extension DefaultCell {
    
    fileprivate func setupUI(){
        contentView.addSubview(iconImage)
        contentView.addSubview(lb_details)
        contentView.addSubview(lb_price)
        contentView.addSubview(lb_expiredPrice)
        
        //设置图片
        iconImage.image?.rightSizeImage(image: iconImage.image!, Size: iconImage.frame.size, completion: { (image) in
            //设置圆角
            image.cornerImageWithSize(size: self.iconImage.frame.size, fillColor: .white, cornerRadius: 15, completion: { (img) in
                self.iconImage.image = img
            })
            
        })
        
        lb_details.layer.masksToBounds = true
        lb_details.backgroundColor = UIColor.white
        lb_price.layer.masksToBounds = true
        lb_price.backgroundColor = UIColor.white
        lb_expiredPrice.layer.masksToBounds = true
        lb_expiredPrice.backgroundColor = UIColor.white
        
        //添加删除线
        let attr = NSMutableAttributedString(string: lb_expiredPrice.text!)
        attr.addAttribute(NSStrikethroughStyleAttributeName, value: NSNumber(value: 2), range: NSMakeRange(0, 4))
        lb_expiredPrice.attributedText = attr
        
        
        iconImage.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.left.equalTo(10)
            make.width.equalTo(100)
            make.bottom.equalTo(contentView).offset(-5)
        }
        lb_details.snp.makeConstraints { (make) in
            make.left.equalTo(iconImage.snp.right).offset(10)
            make.centerY.equalTo(iconImage).offset(-15)
            make.right.equalTo(contentView).offset(-10)
        }
        lb_price.snp.makeConstraints { (make) in
            make.left.equalTo(lb_details)
            make.centerY.equalTo(iconImage).offset(15)
        }
        
        lb_expiredPrice.snp.makeConstraints { (make) in
            make.left.equalTo(lb_price.snp.right).offset(10)
            make.centerY.equalTo(lb_price)
        }
        
        
        //栅格化
        self.layer.drawsAsynchronously = true
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
}
