//
//  UserModel.swift
//  restusers
//
//  Created by Antonie Jovanoski on 9/16/19.
//  Copyright © 2019 Antonie Jovanoski. All rights reserved.
//

import UIKit

class UserModel: NSObject, UITableViewDataSource {
    var users: [User] = [User]()
    
    func refresh(completionHandler: @escaping () -> ()) {
        getUsers { (result) in
            switch result {
                
            case .success(let users):
                self.users = users
                completionHandler()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    // Provide a cell object for each row.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Fetch a cell of the appropriate type.
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        
        // Configure the cell’s contents.
        cell.name.text = users[indexPath.row].name
        cell.username.text = users[indexPath.row].username
        cell.email.text = users[indexPath.row].email
        
        return cell
    }
}

