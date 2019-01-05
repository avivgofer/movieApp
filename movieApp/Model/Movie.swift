//
//  Movie.swift
//  movieApp
//
//  Created by    aviv gofer on 04/01/2019.
//  Copyright © 2019 aviv gofer. All rights reserved.
//

import Foundation
import UIKit


class Movie {
    let id:String
    let name:String
    let year:String
    let category:String
    
    
    init(_id:String, _name:String,_year:String,_category:String){
        id = _id
        name = _name
        year = _year
        category = _category
    }
    
    init(json:[String:Any]) {
        id = json["id"] as! String
        name = json["name"] as! String
        year = json["year"] as! String
        category = json["category"] as! String
    }
}
