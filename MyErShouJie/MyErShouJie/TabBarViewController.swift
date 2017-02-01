//
//  TabBarViewController.swift
//  MyErShouJie
//
//  Created by bingbing on 16/11/7.
//  Copyright © 2016年 yuqibing. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupUI()
        
    }

}

extension TabBarViewController {
    
    fileprivate func setupUI(){
        
        addChildViewController(title: "首页", vc: HomeViewController(), imageName: "Home")
        addChildViewController(title: "分类", vc: ClassViewController(), imageName: "Class")
        addChildViewController(title: "发现", vc: SearchViewController(), imageName: "Search")
        addChildViewController(title: "我", vc: ProfileViewController(), imageName: "Me")
        
    }
    
    fileprivate func addChildViewController(title:String,vc:UIViewController,imageName:String){
        
        vc.title = title
        vc.tabBarItem.image = UIImage(named: imageName)
        let nav = UINavigationController(rootViewController: vc)
        addChildViewController(nav) //添加子控制器
    }
    
}






