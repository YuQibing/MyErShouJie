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

    func upLoad(params:[String:String], success: @escaping (_ response : [String : AnyObject])->(),
                            failure : @escaping (_ error : Error)->()){
        let url = URL(string: baseUrl+"/ershoujie/upload")!
        let headers = ["content-type":"multipart/form-data"]
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                let uiimage = UIImage(contentsOfFile: "/Users/yuqibing/Library/Developer/CoreSimulator/Devices/AF04C24B-5660-4E27-86D2-4AB808D7676D/data/Media/DCIM/100APPLE/IMG_0002.JPG")

                let imagedata = UIImageJPEGRepresentation(uiimage!, 0.3)
                let imagename = "ImageName.png"
                print("imagedata = ", imagedata!)
                //let paramsImagesUrl = params["image_urls"]
                
                multipartFormData.append((params["title"]?.data(using: String.Encoding.utf8)!)!, withName: "title")
                multipartFormData.append((params["description"]?.data(using: String.Encoding.utf8)!)!, withName: "description")
                multipartFormData.append((params["price"]?.data(using: String.Encoding.utf8)!)!, withName: "price")
                multipartFormData.append((params["type"]?.data(using: String.Encoding.utf8)!)!, withName: "type")
                //multipartFormData.append((paramsImagesUrl?.data(using: String.Encoding.utf8)!)!, withName: "image_urls")
                multipartFormData.append(imagedata!, withName: "image_urls", fileName: imagename, mimeType: "image/png")
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

