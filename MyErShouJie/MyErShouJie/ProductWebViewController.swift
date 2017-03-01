//
//  ProductWebViewController.swift
//  MyErShouJie
//
//  Created by bingbing on 01/03/2017.
//  Copyright © 2017 yuqibing. All rights reserved.
//

import UIKit

class ProductWebViewController: UIViewController, UIWebViewDelegate {
    
    var webview: UIWebView?

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://www.baidu.com")
        let urlrequest = URLRequest(url: url!)
        
        let webview = UIWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        self.view.addSubview(webview)
        webview.loadRequest(urlrequest)
        // Do any additional setup after loading the view.
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
