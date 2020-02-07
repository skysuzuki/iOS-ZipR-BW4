//
//  MyRecentActivtyTableViewController.swift
//  ZipR
//
//  Created by Lambda_School_Loaner_204 on 2/3/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class MyRecentActivtyTableViewController: UITableViewController {
    
    var postController: PostController?
    var usersPosts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Activity VC view did load")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        guard let postController = postController else { return }
        postController.fetchPosts { (error) in
            if let _ = error {
                print("Error fetching user's posts")
            } else {
                self.usersPosts = postController.filterPostsByUserandDate(posts: postController.posts, userName: postController.user?.name ?? "")
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usersPosts.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecentActivityCell", for: indexPath) as? MyRecentActivityTableViewCell else {
            return UITableViewCell()
        }
        
        cell.post = usersPosts[indexPath.row]

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let idString = usersPosts[indexPath.row].id
            usersPosts = usersPosts.filter {$0.id != idString}
            postController?.deletePostandItsComments(postId: idString ?? "")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Deletion"), object: self)
            tableView.reloadData()
        }
    }
}
