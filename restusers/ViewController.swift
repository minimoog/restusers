//
//  ViewController.swift
//  restusers
//
//  Created by Antonie Jovanoski on 9/16/19.
//  Copyright © 2019 Antonie Jovanoski. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var userModel: UserModel = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        getUsers { (result) in
//            switch result {
//            case .success(let users):
//                self.users = users
//            case .failure(let error):
//                print("failure: \(error)")
//            }
//        }
        
        tableView.dataSource = userModel
        
        userModel.refresh {
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ShowPostsSegue", let cell = sender as? UserCell, let indexPath = tableView.indexPath(for: cell) else { return }
        
        let userid = userModel.users[indexPath.row].id
        
        guard let destination = segue.destination as? PostsViewController else { return }
        
        destination.userid = userid
    }
}

