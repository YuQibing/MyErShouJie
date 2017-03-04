//
//  ProductWebViewController.swift
//  MyErShouJie
//
//  Created by bingbing on 01/03/2017.
//  Copyright © 2017 yuqibing. All rights reserved.
//

import UIKit

class ProductWebViewController: UIViewController, UIWebViewDelegate {
    
    var path = String()
    var webview: UIWebView?

    override func viewDidLoad() {
        super.viewDidLoad()
        let urlrequest = URLRequest(url: URL(string: path)!)
        let webview = UIWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        self.view.addSubview(webview)
        webview.loadRequest(urlrequest)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setProductDetail(title: String, description: String, imageUrls: [String], price: String){
        
        let tempPath = Bundle.main.resourcePath! + "/productDetailTemp.html"
        let data = NSMutableData()
        var productDetailNewWebString = String()
        
        if let readData = NSData(contentsOfFile: tempPath) {
            let productDetailWebString = String(data: readData as Data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
            productDetailNewWebString = productDetailWebString.replacingOccurrences(of: "TITLE_VALUE", with: title)
            productDetailNewWebString = productDetailNewWebString.replacingOccurrences(of: "PRICE_VALUE", with: price)
            productDetailNewWebString = productDetailNewWebString.replacingOccurrences(of: "DESCRIPTION_VALUE", with: description)
           
            var imageSrc = String()
            for index in 0...imageUrls.count - 1 {
                let imageUrl = imageUrls[index]
                imageSrc += " <img style= \"width: 100%\" src=\""+baseUrl+imageUrl+"\"> "
            }
            productDetailNewWebString = productDetailNewWebString.replacingOccurrences(of: "IMAGURLS_VALUE", with: imageSrc)
            data.append(productDetailNewWebString.data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            let applicationSupportDirectory = FileManager.SearchPathDirectory.cachesDirectory
            let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
            let paths = NSSearchPathForDirectoriesInDomains( applicationSupportDirectory, nsUserDomainMask, true )
            let fileManager = FileManager.default
            self.path = paths[0] + "/" + "productDetail.html"
            
            //  check if the folder already exists
            if fileManager.fileExists( atPath: path ) == false
            {
                fileManager.createFile(atPath: path, contents: nil, attributes: nil)
            }
            data.write(toFile: String(describing: path), atomically: true)
        }
    }
}
