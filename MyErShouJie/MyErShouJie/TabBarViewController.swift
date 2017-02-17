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
        //setupMiddleButton()
        
        
    }
    
//    func setupMiddleButton() {
//        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
//        
//        var menuButtonFrame = menuButton.frame
//        menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height
//        menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
//        menuButton.frame = menuButtonFrame
//        
//        menuButton.backgroundColor = UIColor.red
//        menuButton.layer.cornerRadius = menuButtonFrame.height/2
//        view.addSubview(menuButton)
//        
//        menuButton.setImage(UIImage(named: "example"), for: .normal)
//        menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)
//        
//        view.layoutIfNeeded()
//    }
//    
//    
//    // MARK: - Actions
//    
//    @objc private func menuButtonAction(sender: UIButton) {
//        selectedIndex = 2
//    }



}

extension TabBarViewController {
    
    fileprivate func setupUI(){
        
        addChildViewController(title: "首页", vc: HomeViewController(), imageName: "Home")
        addChildViewController(title: "分类", vc: ClassViewController(), imageName: "Class")
        //addChildViewController(title: "", vc: ButtonController(), imageName: "")
        addChildViewController(title: "发布", vc: PostViewController(), imageName: "Search")
        addChildViewController(title: "我", vc: ProfileViewController(), imageName: "Me")
        
    }
    
    fileprivate func addChildViewController(title:String,vc:UIViewController,imageName:String){
        
        vc.title = title
        vc.tabBarItem.image = UIImage(named: imageName)
        let nav = UINavigationController(rootViewController: vc)
        addChildViewController(nav) //添加子控制器
    }
    
    
    
    
}







