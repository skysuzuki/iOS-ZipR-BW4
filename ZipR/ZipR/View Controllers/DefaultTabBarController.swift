//
//  DefaultTabBarController.swift
//  ZipR
//
//  Created by Lambda_School_Loaner_204 on 2/3/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import PTCardTabBar

class DefaultTabBarController: PTCardTabBarController {
    
    let postController = PostController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewControllers()
    }
    
    override func viewWillLayoutSubviews() {
        if let user = postController.user {
            print("Welcome \(user.name)")
        } else {
            self.performSegue(withIdentifier: "LoginSegue", sender: self)
        }
    }

    private func setUpViewControllers() {
        let messageBoardTVC = self.viewControllers?[1] as? MessageBoardTableViewController
        messageBoardTVC?.postController = self.postController
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

struct CurrentUser {
    let name: String
    let longitude: Int?
    let latitude: Int?
}
