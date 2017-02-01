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



class ClassViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableview: UITableView!
    var item = ["书籍", "电子产品", "体育用品", "生活用品", "交通工具"]

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
            cell?.textLabel?.text = item[indexPath.row]
        default:
            break
        }
        
        cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case 0:
            if(indexPath.row == 0){
                let book = ClassBook()
                book.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(book, animated: false)
            }
            if(indexPath.row == 1){
                let electronic = ClassElectronic()
                electronic.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(electronic, animated: false)
            }
            if(indexPath.row == 2){
                let sports = ClassSports()
                sports.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(sports, animated: false)
            }
            if(indexPath.row == 3){
                let daily = ClassDaily()
                daily.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(daily, animated: false)
            }
            if(indexPath.row == 4){
                let trafic = ClassTraffic()
                trafic.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(trafic, animated: false)
            }
        default:
            break
        }
    }
    
    
    
    
            
    
    
    
    

    


}
