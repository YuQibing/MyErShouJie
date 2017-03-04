//
//  ServerAPI.swift
//  MyErShouJie
//
//  Created by bingbing on 05/02/2017.
//  Copyright © 2017 yuqibing. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ServerAPI: NSObject {
    
    
    func list(completion : @escaping (JSON) -> ()){
        var json: JSON = []
        let str = "*"
        let url = URL(string: baseUrl+"/ershoujie/list?searchKeyWords="+str)!
        print("----ServerAPI list:-------", url)
        
        Alamofire.request(url).responseJSON{ response in
            if response.result.isSuccess{
            let value = response.result.value
                json = JSON(value!)
                //print("JSON COUNT = ", json.count)
                //print("JSON VALUE = ", json)
                completion(json)
            }
        }
    }
    
    func listByType(type: Int, completion : @escaping (JSON) -> ()){
        var json: JSON = []
        let str = "*&type="+String(type+1)
        let url = URL(string: baseUrl+"/ershoujie/list?searchKeyWords="+str)!
        print("----ServerAPI list:-------", url)
        
        Alamofire.request(url).responseJSON{ response in
            if response.result.isSuccess{
                let value = response.result.value
                json = JSON(value!)
                //print("JSON COUNT = ", json.count)
                //print("JSON VALUE = ", json)
                completion(json)
            }
        }
    }

    func upLoad(params:[String:String], paramsImages: Array<UIImage>, success: @escaping (_ response : [String : AnyObject])->(),
                            failure : @escaping (_ error : Error)->()){
        let url = URL(string: baseUrl+"/ershoujie/upload")!
        print("uploadURL======= ", url)
        let headers = ["content-type":"multipart/form-data"]
        //print("params iamge_ruls", params["image_urls"]!)
        
        
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                print("paramsAll =====", params)
                multipartFormData.append((params["title"]?.data(using: String.Encoding.utf8)!)!, withName: "title")
                multipartFormData.append((params["description"]?.data(using: String.Encoding.utf8)!)!, withName: "description")
                multipartFormData.append((params["price"]?.data(using: String.Encoding.utf8)!)!, withName: "price")
                multipartFormData.append((params["type"]?.data(using: String.Encoding.utf8)!)!, withName: "type")
                for index in 0...paramsImages.count - 1 {
//                    let image = UIImage(contentsOfFile: paramsImageUrls[index])
//                    print("paramsImageUrls = ", paramsImageUrls[index])
                    let imagedata = UIImageJPEGRepresentation(paramsImages[index], 0.1)
                    multipartFormData.append(imagedata!, withName: "image_urls", fileName: "ImageName.JPG", mimeType: "image/jpeg")
                }
            },
            to: url,
            headers: headers,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if let value = response.result.value as? [String: AnyObject]{
                            success(value)
                            let json = JSON(value)
                            print("success json = ", json)
                        }
                    }
                case .failure(let encodingError):
                    print("failure error = ", encodingError)
                    failure(encodingError)
                }
        })
    }
}

