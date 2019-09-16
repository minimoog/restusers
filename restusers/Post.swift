//
//  Post.swift
//  restusers
//
//  Created by Antonie Jovanoski on 9/16/19.
//  Copyright © 2019 Antonie Jovanoski. All rights reserved.
//

import Foundation

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

func getPosts(userid: Int, completionHandler: @escaping (Result<[Post], NetworkError>) -> Void) {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "jsonplaceholder.typicode.com"
    urlComponents.path = "/posts"
    urlComponents.queryItems = [URLQueryItem(name: "userId", value: "\(userid)")]
    
    guard let url = urlComponents.url else {
        completionHandler(.failure(.urlError))
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    let session = URLSession(configuration: .default)
    
    let task = session.dataTask(with: request) { (data, response, responseError) in
        DispatchQueue.main.async {
            if responseError != nil {
                completionHandler(.failure(.responseError))
            } else if let jsonData = data {
                let decoder = JSONDecoder()
                
                do {
                    let posts = try decoder.decode([Post].self, from: jsonData)
                    
                    completionHandler(.success(posts))
                } catch {
                    completionHandler(.failure(.parsingError))
                }
            }
        }
    }
    
    task.resume()
}
