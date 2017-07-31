//
//  NetworkClient.swift
//  ProductHunt
//
//  Created by Никита on 13.07.17.
//  Copyright © 2017 Nikita Susoev. All rights reserved.
//

import UIKit
import Alamofire


class NetworkClient: NSObject {
    
    let accessToken = "591f99547f569b05ba7d8777e2e0824eea16c440292cce1f8dfb3952cc9937ff"
    let path = "https://api.producthunt.com/v1/"
    
    
    func obtainPosts(withCategoryName categoryName: String, response: @escaping (_ response: DataResponse<Any>) -> Void) {
        let params = ["access_token": accessToken,
                      "search[category]": categoryName,
                      "sort_by":"created_at",
                      "order":"desc"]
        
        Alamofire.request(path + "posts",
                          parameters: params).validate().responseJSON(completionHandler: response)
    }
    
    func obtainCategories(response: @escaping (_ response: DataResponse<Any>) -> Void) {
        let params = ["access_token": accessToken]
        
        Alamofire.request(path + "categories",
                          parameters: params).validate().responseJSON(completionHandler: response)
    }
}
