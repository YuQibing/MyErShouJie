//
//  ProfilePersonDetails.swift
//  MyErShouJie
//
//  Created by bingbing on 16/11/9.
//  Copyright © 2016年 yuqibing. All rights reserved.
//

import UIKit

class ProfilePersonDetails: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dataTable:UITableView!
    var ItemString = ["昵称", "性别", "手机号"]
    var screenObject = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "个人信息"
        let dataTable: UITableView = UITableView(frame:CGRect(x: 0, y: 0, width: screenObject.width, height: screenObject.height),style:UITableViewStyle.grouped)
        dataTable.delegate = self
        dataTable.dataSource = self
        self.view.addSubview(dataTable)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "identifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if(cell == nil){
            cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: identifier)
        }
        
        if(indexPath.section == 0){
            cell?.textLabel?.text = ItemString[indexPath.row]
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
}
