//
//  DefaultTabBarController.swift
//  ZipR
//
//  Created by Lambda_School_Loaner_204 on 2/3/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import PTCardTabBar
import CoreLocation

class DefaultTabBarController: PTCardTabBarController {
    
    let postController = PostController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewControllers()
    }
    
    override func viewWillLayoutSubviews() {
        
        guard let _ = postController.user else {
            self.performSegue(withIdentifier: "LoginSegue", sender: self)
            return
        }
    }
    private func setUpViewControllers() {
        let messageBoardTVC = self.viewControllers?[1] as? MessageBoardTableViewController
        messageBoardTVC?.postController = self.postController
        
        let activityTVC = self.viewControllers?[0] as? MyRecentActivtyTableViewController
        activityTVC?.postController = self.postController
//        activityTVC?.usersPosts = fetchUsersPosts()
//        activityTVC?.tableView.reloadData()
    }
    
    private func fetchUsersPosts() -> [Post] {
        var posts: [Post] = []
        self.postController.fetchPosts { (error) in
            if let _ = error {
                print("Error fetching user's posts")
            } else {
                posts = self.postController.filterPostsByUserandDate(posts: self.postController.posts, userName: self.postController.user?.name ?? "")
            }
        }
        return posts
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoginSegue" {
            let destinationVC = segue.destination as? LoginViewController
            destinationVC?.postController = postController
        }
    }
}

