//
//  Users.swift
//  restusers
//
//  Created by Antonie Jovanoski on 9/16/19.
//  Copyright © 2019 Antonie Jovanoski. All rights reserved.
//

import UIKit

struct User: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
}

enum NetworkError: Error {
    case responseError
    case parsingError
    case urlError
}

func getUsers(completionHandler: @escaping (Result<[User], NetworkError>) -> Void) {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "jsonplaceholder.typicode.com"
    urlComponents.path = "/users"
    
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
                    let users = try decoder.decode([User].self, from: jsonData)
                    
                    completionHandler(.success(users))
                } catch {
                    completionHandler(.failure(.parsingError))
                }
            }
        }
    }
    
    task.resume()
}
