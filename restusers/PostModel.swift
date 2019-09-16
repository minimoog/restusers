//
//  PostModel.swift
//  restusers
//
//  Created by Antonie Jovanoski on 9/16/19.
//  Copyright © 2019 Antonie Jovanoski. All rights reserved.
//

import UIKit

class PostModel: NSObject, UITableViewDataSource {
    var userid: Int?
    var posts: [Post] = [Post]()
    
    func refresh(completionHandler: @escaping () -> ()) {
        guard let userid = userid else { fatalError() }
        
        getPosts(userid: userid) { (result) in
            switch result {
                
            case .success(let posts):
                self.posts = posts
                completionHandler()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    // Provide a cell object for each row.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Fetch a cell of the appropriate type.
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        
        cell.title.text = posts[indexPath.row].title
        cell.body.text = posts[indexPath.row].body
        
        return cell
    }
}
