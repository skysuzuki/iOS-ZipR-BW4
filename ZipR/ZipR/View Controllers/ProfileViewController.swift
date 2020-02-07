//
//  ProfileViewController.swift
//  ZipR
//
//  Created by Lambda_School_Loaner_204 on 2/3/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import GoogleSignIn
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    var postController: PostController?

    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    
    @IBAction func signOutTapped(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signOut()
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            self.postController?.user = nil
            
            if let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                loginVC.postController = PostController()
                present(loginVC, animated: true, completion: nil)
            }
            
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
    
    func updateViews() {
        usernameTF.text = Auth.auth().currentUser?.displayName
        emailTF.text = Auth.auth().currentUser?.email
        usernameTF.isUserInteractionEnabled = false
        emailTF.isUserInteractionEnabled = false
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
