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
    
    func list() -> JSON {
        var json: JSON = []
        
        let str = "*"
        let url = URL(string:"http://localhost:8080/list?searchKeyWords="+str)!
        print("----ServerAPI list:-------", url)
        Alamofire.request(url).responseJSON { response in
            if let value = response.result.value {
                json = JSON(value)
                print("JSON Count=",json.count)
                print("JSON =",json)
            }
        }
        return json
    }
}
//                print("value: ",value)
//                    let json = JSON(value)
//                    if let title = json[0]["title"].string{
//                        print(json.count)
//                        print("title: ", title)
//                    }else{
//                        print("error")
//
//                }
//        }

        
        
//        Alamofire.request(url!).responseJSON{ response in
//            
//            
//            print(response.request)  // original URL request
//            print(response.response) // HTTP URL response
//            print(response.data)     // server data
//            print(response.result)   // result of response serialization
//            
//            if let JSON = response.result.value {
//                print("JSON: \(JSON)")
//            }
//        }
        

