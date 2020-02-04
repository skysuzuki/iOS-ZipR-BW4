//
//  PostController.swift
//  ZipR
//
//  Created by Dennis Rudolph on 2/3/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
import FirebaseDatabase

class PostController {
    
    var user: CurrentUser?
    var ref: DatabaseReference!
    var posts: [Post] = []
    
    init() {
        ref = Database.database().reference()
    }
    
    func createPost(author: String, title: String, description: String) {
        let post = Post(authorName: author, title: title, description: description, id: nil)
        self.ref.child("Posts").child(post.id ?? UUID().uuidString).setValue(post.dictionaryRepresentation) { (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("Data could not be saved: \(error).")
                return
            } else {
                print("Data saved successfully!")
            }
        }
    }
    
    //updates self.posts with all posts on Firebase
    func fetchPosts(completion: @escaping (Error?) -> Void) {
        self.posts = []
        guard let ref = self.ref else { return print("here")}
        ref.child("Posts").observeSingleEvent(of: .value) { (snapshot) in
            
            guard let posts = snapshot.value as? [String: Any] else {
                NSLog("Error printing authors")
                return
            }
            for p in posts {
                guard let postRep = p.value as? [String: Any],
                    let post = Post(dictionary: postRep) else { print("Trouble fetching posts data")
                        continue }
                self.posts.append(post)
            }
            print("\(self.posts.count)")
            completion(nil)
        }
    }
}
