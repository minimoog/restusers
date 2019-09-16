//
//  PostsViewController.swift
//  restusers
//
//  Created by Antonie Jovanoski on 9/16/19.
//  Copyright © 2019 Antonie Jovanoski. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var postsTableView: UITableView!
    
    var userid: Int?
    var postModel: PostModel = PostModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        postsTableView.dataSource = postModel
        
        guard let userid = userid else { return }
        
        postModel.userid = userid
        postModel.refresh {
            self.postsTableView.reloadData()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
