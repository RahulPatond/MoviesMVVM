//
//  MoviesClient.swift
//  MoviesVVM
//
//  Created by Rahul Patond on 29/06/17.
//  Copyright © 2017 Rahul Patond. All rights reserved.
//

import UIKit
import Foundation

class MoviesClient: NSObject {
    
    func fetchMovies(completion: @escaping ([NSDictionary]?) -> ())  {
        //fetch the data
        //call the completion block
        
        let urlStr = "https://itunes.apple.com/us/rss/topmovies/limit=2/json"
        let url = URL(string: urlStr)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                completion(nil)
                return
            }
            
            //TODO: check the response status code
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary
                
                if let movies = json?.value(forKeyPath: "feed.entry") as? [NSDictionary]{
                    completion(movies)
                    return
                }
            } catch {
                
            }
        }
        task.resume()
        
    }
}
