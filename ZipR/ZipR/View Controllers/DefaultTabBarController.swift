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
import FirebaseAuth


class DefaultTabBarController: UITabBarController {
    
    let postController = PostController()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.selectedIndex = 1
        if Auth.auth().currentUser != nil {
            guard let name = Auth.auth().currentUser?.displayName else { return }
            Location.shared.getCurrentLocation { (coordinate) in
                guard let coordinate = coordinate else { return }
                let lat = coordinate.latitude
                let long = coordinate.longitude
                let latString = String(lat)
                let longString = String(long)
                let loggeduser = CurrentUser(name: name, longitude: longString, latitude: latString)
                self.postController.user = loggeduser
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UserWasLoggedIn"), object: self)
                print("Welcome \(name)")
            }
        } else {
            guard let _ = postController.user else {
                if let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                    loginVC.postController = self.postController
                    present(loginVC, animated: true, completion: nil)
                }
                return

            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewControllers()
    }
    
    private func setUpViewControllers() {
        let messageBoardTVC = self.viewControllers?[1] as? MessageBoardTableViewController
        messageBoardTVC?.postController = self.postController
        
        let activityTVC = self.viewControllers?[0] as? MyRecentActivtyTableViewController
        activityTVC?.postController = self.postController
        
        let profileVC = self.viewControllers?[2] as? ProfileViewController
        profileVC?.postController = self.postController
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
        //        if segue.identifier == "LoginSegue" {
        //            let destinationVC = segue.destination as? LoginViewController
        //            destinationVC?.postController = postController
        //        }
    }
}

