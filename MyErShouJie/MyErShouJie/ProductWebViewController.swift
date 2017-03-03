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
        //let url = URL(string: "https://www.baidu.com")
        let path = Bundle.main.resourcePath! + "/productDetail.html"
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
        let viewPath = Bundle.main.resourcePath! + "/productDetail.html"
        let data = NSMutableData()
        var productDetailNewWebString = String()
        //var productDetailNewWebString = ""
//        data.append("hello".data(using: String.Encoding.utf8, allowLossyConversion:true)!)
//        data.write(toFile: path, atomically: true)
        
        
        if let readData = NSData(contentsOfFile: tempPath) {
            let productDetailWebString = String(data: readData as Data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
            print("productDetailWebString:", productDetailWebString)
            
            
            productDetailNewWebString = productDetailWebString.replacingOccurrences(of: "TITLE_VALUE", with: title)
            productDetailNewWebString = productDetailNewWebString.replacingOccurrences(of: "PRICE_VALUE", with: price)
            productDetailNewWebString = productDetailNewWebString.replacingOccurrences(of: "DESCRIPTION_VALUE", with: description)
           
            var imageSrc = String()
            for index in 0...imageUrls.count - 1 {
                let imageUrl = imageUrls[index]
                
                imageSrc += " <img style= \"width: 100%\" src=\""+imageUrl+"\"> "
                
                print("imageSrc", imageSrc)
                
            }
                productDetailNewWebString = productDetailNewWebString.replacingOccurrences(of: "IMAGURLS_VALUE", with: imageSrc)
            
            print("productDetailNewWebString", productDetailNewWebString)
            data.append(productDetailNewWebString.data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            data.write(toFile: viewPath, atomically: true)
        }
        
        
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


