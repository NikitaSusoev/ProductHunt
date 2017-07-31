//
//  Post.swift
//  ProductHunt
//
//  Created by Никита on 09.07.17.
//  Copyright © 2017 Nikita Susoev. All rights reserved.
//

import UIKit

struct Post {
    
    var name: String
    var tagline: String
    var thumbnailImageURL: String?
    var screenshotURL_850px: String?
    var votesCount: Int?
    var websiteURL: String?
    
    init?(json: [String: Any]) {
        let thumbnail = json["thumbnail"] as? [String:Any]
        let screenshotURL = json["screenshot_url"] as? [String:Any]
        let user = json["user"] as? [String:Any]
        
        let name = json["name"] as? String ?? "Unknown"
        let tagline = json["tagline"] as? String ?? "Unknown"
        let thumbnailImageURL = thumbnail?["image_url"] as? String ?? nil
        let screenshotURL_850px = screenshotURL?["850px"] as? String ?? nil
        let votesCount = json["votes_count"] as? Int ?? nil
        let websiteURL = user?["website_url"] as? String ?? nil
        
        self.name = name
        self.tagline = tagline
        self.thumbnailImageURL = thumbnailImageURL
        self.screenshotURL_850px = screenshotURL_850px
        self.votesCount = votesCount
        self.websiteURL = websiteURL
    }
    
    static func getArray(from jsonArray: Any) -> [Post]? {
        guard let tempJsonArray1 = jsonArray as? [String: Any] else {
            return nil
        }
        
        guard let tempJsonArray2 = tempJsonArray1["posts"] as? Array<[String:Any]>  else {
            return nil
        }
        
        var posts: [Post] = []
        
        for jsonObject in tempJsonArray2 {
            if let post = Post(json: jsonObject) {
                posts.append(post)
            }
        }
        
        return posts
    }
}
