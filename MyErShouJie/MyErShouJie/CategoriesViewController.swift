//
//  ClassViewController.swift
//  MyErShouJie
//
//  Created by bingbing on 16/11/7.
//  Copyright © 2016年 yuqibing. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class CategoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableview: UITableView!
    
    var index: IndexPath!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "分类"
        let tableview = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), style: UITableViewStyle.grouped)
        
        tableview.delegate = self
        tableview.dataSource = self
        self.view.addSubview(tableview)
    }
    
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "identifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if(cell == nil){
            cell = UITableViewCell(style:UITableViewCellStyle.value1,reuseIdentifier:identifier)
        }
        
        switch indexPath.section {
        case 0:
            cell?.textLabel?.text = productType[indexPath.row]
        default:
            break
        }
        
        cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let categoryViewController = CategoryViewController()
        categoryViewController.navigationItem.title = productType[indexPath.row]
        categoryViewController.type = indexPath.row
        categoryViewController.getDataFromServer()
        categoryViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(categoryViewController, animated: false)
    }

}
