//
//  Constant.swift
//  MyErShouJie
//
//  Created by bingbing on 10/02/2017.
//  Copyright © 2017 yuqibing. All rights reserved.
//

import Foundation

#if DEBUG
let baseUrl = "http://localhost:8080"
//    let baseUrl = "http://101.200.164.28:8080"
#else
let baseUrl = "http://101.200.164.28:8080"
#endif

var productType = ["书籍", "电子产品", "体育用品", "生活用品", "交通工具"]
let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height

