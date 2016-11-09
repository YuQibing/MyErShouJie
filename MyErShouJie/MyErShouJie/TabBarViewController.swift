//
//  TabBarViewController.swift
//  MyErShouJie
//
//  Created by bingbing on 16/11/7.
//  Copyright © 2016年 yuqibing. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController{

    class func TabbarViewController() ->UITabBarController{
        //创建四个view
        let HomeVc = HomeViewController()
        let HomeNvc = UINavigationController(rootViewController: HomeVc)
        let ImgHome = UIImage(named:"Home")
        HomeNvc.tabBarItem = UITabBarItem(title: "首页", image: ImgHome, tag: 0)
        
        let IssueVc = IssueViewController()
        let IssueNvc = UINavigationController(rootViewController: IssueVc)
        let ImgIssue = UIImage(named:"Issue")
        IssueNvc.tabBarItem = UITabBarItem(title: "发布", image: ImgIssue, tag: 1)
        
        
        let SearchVc = SearchViewController()
        let SearchNvc = UINavigationController(rootViewController: SearchVc)
        let ImgSearch = UIImage(named:"Search")
        SearchNvc.tabBarItem = UITabBarItem(title: "发现", image: ImgSearch, tag: 2)
        
        let MeVc = MeViewController()
        let MeNvc = UINavigationController(rootViewController: MeVc)
        let ImgMe = UIImage(named: "Me")
        MeNvc.tabBarItem = UITabBarItem(title: "我", image: ImgMe, tag: 3)
        
        
        //创建TabBar
        let tc = UITabBarController()
        tc.viewControllers = [HomeNvc, IssueNvc, SearchNvc, MeNvc]
        
        return tc
    }


}
