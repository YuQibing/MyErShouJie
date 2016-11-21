//
//  RootViewController.swift
//  MyErShouJie
//
//  Created by bingbing on 16/11/20.
//  Copyright © 2016年 yuqibing. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    
    var finished:((_ str:String)->())?
    
    override func loadView() {
        
        setupUI()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    //公共属性
    var tableView:UITableView?
    
    deinit {
        print("销毁")
    }
    
}
extension RootViewController {
    
    fileprivate func setupUI(){
        
        //实例化tableView
        tableView = UITableView(frame: .zero, style: .plain)
        view = tableView
        
        tableView?.backgroundColor = UIColor.white
        tableView?.delegate = self
        tableView?.dataSource = self
        
    }
    
    
}

extension RootViewController:UITableViewDelegate,UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 0
    }
    
}
