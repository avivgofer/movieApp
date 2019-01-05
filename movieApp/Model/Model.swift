//
//  Model.swift
//  movieApp
//
//  Created by    aviv gofer on 04/01/2019.
//  Copyright © 2019 aviv gofer. All rights reserved.
//

import Foundation
import UIKit

class Model {
    
    static let instance:Model = Model()
    let movieUrl = "https://x-mode.co.il/exam/allMovies/allMovies.txt"
    let fullMovieUrlWithoutId = "https://x-mode.co.il/exam/descriptionMovies/"
    
    private init(){
    }
    
    func getFullMovieById(id:String,callback:@escaping (FullMovie)->()){
        let url = URL(string: fullMovieUrlWithoutId + id + ".txt")
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            do {
                let moviesJson = try JSONSerialization.jsonObject(with: data, options:.allowFragments) as! [String:Any]
                callback(FullMovie(json: moviesJson))
            } catch let error as NSError {
                print(error)
            }
        }).resume()
    }
    
    func getAllMovies(callback:@escaping ([Movie])->()){
        let url = URL(string: movieUrl)
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            print(data)
            
            do {
                var tempMovies = [Movie]()
                let moviesJson = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                for movieJson in moviesJson["movies"]! as! NSArray{
                    tempMovies.append(Movie(json: movieJson as! [String : Any]))
                }
                tempMovies.sort(by: { $1.year.compare($0.year) == .orderedAscending })
                callback(tempMovies)
            } catch let error as NSError {
                print(error)
            }
        }).resume()
    }
   
    
}

