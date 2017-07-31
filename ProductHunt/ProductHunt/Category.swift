//
//  Category.swift
//  ProductHunt
//
//  Created by Никита on 09.07.17.
//  Copyright © 2017 Nikita Susoev. All rights reserved.
//

struct Category {

    var color: String
    var id: Int
    var name: String
    var slug: String
    
    init?(json: [String: Any]) {
        guard
            let color = json["color"] as? String,
            let id = json["id"] as? Int,
            let name = json["name"] as? String,
            let slug = json["slug"] as? String
            else {
                return nil
        }
        
        self.color = color
        self.id = id
        self.name = name
        self.slug = slug
    }
    
    static func getArray(from jsonArray: Any) -> [Category]? {
        guard let tempJsonArray1 = jsonArray as? [String: Any] else {
            return nil
        }
        
        guard let tempJsonArray2 = tempJsonArray1["categories"] as? Array<[String:Any]>  else {
            return nil
        }

        var categories: [Category] = []
        
        for jsonObject in tempJsonArray2 {
            if let category = Category(json: jsonObject) {
                categories.append(category)
            }
        }
        
        return categories
    }
}
