//
//  UIImage+Extension.swift
//  MyErShouJie
//
//  Created by bingbing on 16/11/19.
//  Copyright © 2016年 yuqibing. All rights reserved.
//

import UIKit

extension UIImage {
    
    //创建一个‘点’的图像
    class func DotImage(color: UIColor) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), false, UIScreen.main.scale)
        
        color.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: 1, height: 1))
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return result!
    }
    
    //本地图片裁剪 
    //parameter image ： 要裁剪的图片
    //parameter size ： 裁剪size
    func rightSizeImage(image: UIImage, size: CGSize) -> UIImage{
        
        UIGraphicsBeginImageContextWithOptions(size, true, UIScreen.main.scale)
        
        //绘制图像
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return result!
        
    }
    
    //异步剪裁图片
    //parameter completion： 完成回调
    func rightSizeImage(image: UIImage, Size: CGSize, completion: @escaping (_ img:UIImage) ->()) {
        DispatchQueue.global().async {
            UIGraphicsBeginImageContextWithOptions(Size, true, UIScreen.main.scale)
            
            //填充颜色
            let color = UIColor.white
            color.setFill()
            let rect = CGRect(x: 0, y: 0, width:Size.width, height: Size.height)
            UIRectFill(rect)
            
            image.draw(in: rect)
            
            let result = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            
            DispatchQueue.main.async {
                guard let image = result else{
                    return
                }
                completion(image)
            }

        }
    }
    // 异步生成圆角图像
    //
    //  parameter size:         图片size
    //  parameter fillColor:    填充颜色
    //  parameter cornerRadius: 圆角
    //  parameter completion:   回调
    func cornerImageWithSize(size:CGSize,fillColor:UIColor,cornerRadius:CGFloat,completion:@escaping (_ img:UIImage)->()){
        
        DispatchQueue.global().async {
            
            UIGraphicsBeginImageContextWithOptions(size, true, UIScreen.main.scale)
            //填充颜色
            fillColor.setFill()
            let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            UIRectFill(rect)
            
            let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
            
            path.addClip()
            
            self.draw(in: rect)
            
            let result = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            
            DispatchQueue.main.async {
                guard let image = result else{
                    return
                }
                completion(image)
            }

    
        }
    }
}
