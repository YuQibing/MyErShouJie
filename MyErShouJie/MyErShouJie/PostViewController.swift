//
//  PostViewController.swift
//  MyErShouJie
//
//  Created by bingbing on 16/11/7.
//  Copyright © 2016年 yuqibing. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = ""
        let img = UIImage(named: "post")
        let item = UIBarButtonItem(image: img, style: UIBarButtonItemStyle.plain, target: self, action: #selector(PostViewController.post))
        self.navigationItem.rightBarButtonItem = item
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func post() {
        let postcontroller = PostController()
        postcontroller.hidesBottomBarWhenPushed = true
        navigationController?.present(postcontroller, animated: true, completion: nil)
        
        
    }
    
    
    
    
        
}
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


