//
//  HomeViewController.swift
//  MyErShouJie
//
//  Created by bingbing on 16/11/7.
//  Copyright © 2016年 yuqibing. All rights reserved.
//

import UIKit
let homeIdentifier:String = "homecell"
let scrollIdentifier:String = "scrollcell"
let listIdentifier:String = "listcell"
let defaultIdentifier:String = "defaultcell"


class HomeViewController: RootViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "首页"
        
        tableView?.register(HomeHeadCell.self, forCellReuseIdentifier: homeIdentifier)
        tableView?.register(HomeScrollCell.self, forCellReuseIdentifier: scrollIdentifier)
        tableView?.register(HomeListCell.self, forCellReuseIdentifier: listIdentifier)
        tableView?.register(HomeDefaultCell.self, forCellReuseIdentifier: defaultIdentifier)

    }

}

extension HomeViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 4
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section < 3 {
            return 1
        }
        
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell?
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: homeIdentifier, for: indexPath) as! HomeHeadCell
            break
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: scrollIdentifier, for: indexPath) as! HomeScrollCell
            break
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: listIdentifier, for: indexPath)
            break
        default:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: defaultIdentifier, for: indexPath) as! HomeDefaultCell
            
            cell.indexPath = indexPath
            
            return cell
        }
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.row)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 && indexPath.row == 0 {
            
            return 200
        }
        else if indexPath.section == 1 && indexPath.row == 0 {
            
            return ScreenWidth/2
        }
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    
}

