//
//  IssueViewController.swift
//  MyErShouJie
//
//  Created by bingbing on 16/11/7.
//  Copyright © 2016年 yuqibing. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class itemModel: NSObject {
    
    var cover_image_url = ""
    var title = ""
    var likecount = ""
}


class IssueViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var Issuetableview: UITableView!
    
    var dataArray = [itemModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "发布"
        Issuetableview.delegate = self
        Issuetableview.dataSource = self
        
        DownLoadData()
    }
    
    //下载解析数据
    func DownLoadData() -> Void {
        Alamofire.request( "http://api.liwushuo.com/v2/channels/104/items?ad=2&gender=2&generation=2&limit=20&offset=0").responseJSON {
            (response)   in
            if let Error = response.result.error {
                print(Error)
            }else if let jsonresult = response.result.value {
                // 用 SwiftyJSON 解析数据
                let JSOnDictory = JSON(jsonresult )
                let data =  JSOnDictory["data"]["items"].array
                for dataDic in  data!
                {
                    
                    let model =  itemModel()
                    model.cover_image_url = dataDic["cover_image_url"].string ?? ""
                    model.title =  dataDic["title"].string ?? ""
                    
                    let  numString = String(format:"%d",dataDic["likes_count"].intValue ?? 0)
                    model.likecount = numString
                    self.dataArray.append(model)
                    
                }
                
                self.Issuetableview.reloadData()
                
                //print(jsonresult)
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView .dequeueReusableCell(withIdentifier: "Gifsayidentifile") as! IssueTableViewCell
        let model = self.dataArray[indexPath.row]
 //       cell.likeNumberLabel.text = model.likecount
        
        // 这个就是用到 Kingfisher
//        cell.backGroundImage.kf_setImageWithURL(NSURL(string: model.cover_image_url)!)
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print(indexPath.row)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
                
            
    
    
    
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
