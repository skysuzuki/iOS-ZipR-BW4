//
//  DefaultTabBarController.swift
//  ZipR
//
//  Created by Lambda_School_Loaner_204 on 2/3/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import SOTabBar
import CoreLocation
import FirebaseAuth

class DefaultTabBarController: SOTabBarController {
    
    let postController = PostController()

    override func loadView() {
        super.loadView()
        SOTabBarSetting.tabBarTintColor = UIColor.forestGreen
        SOTabBarSetting.tabBarBackground = UIColor.mossGreen
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        //self.selectedIndex = 1
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

        let messageBoardTVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MessageBoardNavController")

        let activityTVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ActivityNavController")

        let profileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileNavController")

        let listDashImage = UIImage(systemName: "list.dash")
        let clockImage = UIImage(systemName: "clock")
        let personImage = UIImage(systemName: "person")

        messageBoardTVC.tabBarItem = UITabBarItem(title: "My Feed",
                                                  image: listDashImage?.withTintColor(UIColor.forestGreen, renderingMode: .alwaysOriginal),
                                                  selectedImage: listDashImage?.withTintColor(UIColor.mossGreen, renderingMode: .alwaysOriginal))

        activityTVC.tabBarItem = UITabBarItem(title: "Recent Activity",
                                              image: clockImage?.withTintColor(UIColor.forestGreen, renderingMode: .alwaysOriginal),
                                              selectedImage: clockImage?.withTintColor(UIColor.mossGreen, renderingMode: .alwaysOriginal))

        profileVC.tabBarItem = UITabBarItem(title: "Profile",
                                            image: personImage?.withTintColor(UIColor.forestGreen, renderingMode: .alwaysOriginal),
                                            selectedImage: personImage?.withTintColor(UIColor.mossGreen, renderingMode: .alwaysOriginal))

        viewControllers = [messageBoardTVC, activityTVC, profileVC]

        if let messageBoardNC = self.viewControllers[0] as? UINavigationController {
            let messageBoardTVC = messageBoardNC.topViewController as? MessageBoardTableViewController
            messageBoardTVC?.postController = self.postController
        }

        if let activityNC = self.viewControllers[1] as? UINavigationController {
            let activityTVC = activityNC.topViewController as? MyRecentActivtyTableViewController
            activityTVC?.postController = self.postController
        }

        if let profileNC = self.viewControllers[2] as? UINavigationController {
            let profileVC = profileNC.topViewController as? ProfileViewController
            profileVC?.postController = self.postController
        }

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
}

