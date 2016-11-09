//
//  MeViewController.swift
//  MyErShouJie
//
//  Created by bingbing on 16/11/7.
//  Copyright © 2016年 yuqibing. All rights reserved.
//

import UIKit

class MeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var dataTable:UITableView!
    var ItemString = ["我发布的", "我卖出的", "我买到的"]
    var set = ["设置"]
    var screenObject = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "我"
        let dataTable: UITableView = UITableView(frame:CGRect(x: 0, y: 0, width: screenObject.width, height: screenObject.height),style:UITableViewStyle.grouped)
        dataTable.delegate = self
        dataTable.dataSource = self //实现数据源
        self.view.addSubview(dataTable)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        case 2:
            return 1
        default:
            break
        }
        return 0
    }
    
    private func tableVew(tableViwe:UITableView,heightForRowAtIndexPath indexPath:NSIndexPath)->CGFloat{
        if(indexPath.section == 0){
            return 80
        }else{
            return 55
        }
    }
    
    private func tableView(tableView: UITableView,heightForHeaderInSection section:Int)-> CGFloat{
        return 10
    }
    
    private func tableView(tableView: UITableView,heightForFooterInSection section:Int)-> CGFloat{
        return 1
    }
    //返回数据源
    func tableView(_ tableView:UITableView,cellForRowAt indexPath:IndexPath)-> UITableViewCell{
        let identifier = "identifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if(cell == nil){
            cell = UITableViewCell(style:UITableViewCellStyle.value1,reuseIdentifier:identifier)
        }
        
        switch indexPath.section {
        case 0:
            cell?.textLabel?.text = "个人信息"
        case 1:
            cell?.textLabel?.text = ItemString[indexPath.row]
        case 2:
            cell?.textLabel?.text = set[indexPath.row]
        default:
            break
            
        }
        
        cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("点击了 \(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated: true)  //取消选中的样式
        
        switch indexPath.section {
        case 0:
            let person = Person()
            person.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(person, animated: false)
        case 1:
            if(indexPath.row == 0){
                let issue = Issue()
                issue.hidesBottomBarWhenPushed = true  //隐藏tabbar
                self.navigationController?.pushViewController(issue, animated: false)
            }
            if(indexPath.row == 1){
                let sell = Sell()
                sell.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(sell, animated: false)
            }
            if(indexPath.row == 2){
                let buy = Buy()
                buy.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(buy, animated: false)
            }
        case 2:
            let set = Set()
            set.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(set, animated: false)
        default:
            break
            
        }
        
    }
    
}
