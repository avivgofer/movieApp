//
//  FullMovie.swift
//  movieApp
//
//  Created by    aviv gofer on 04/01/2019.
//  Copyright © 2019 aviv gofer. All rights reserved.
//

import Foundation
import UIKit


class FullMovie {
    
    let id:String
    let name:String
    let year:String
    let category:String
    let description:String
    let imageUrl:String
    let promoUrl:String
    let rate:String
    let hour:String
    
    
    
    init(json:[String:Any]) {
        id = json["id"] as! String
        name = json["name"] as! String
        year = json["year"] as! String
        category = json["category"] as! String
        description = json["description"] as! String
        imageUrl = json["imageUrl"] as! String
        promoUrl = json["promoUrl"] as! String
        rate = json["rate"] as! String
        hour = json["hour"] as! String
        
    }
}

