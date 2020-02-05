//
//  CommentController.swift
//  ZipR
//
//  Created by Dennis Rudolph on 2/4/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
import FirebaseDatabase

class CommentController {
    
    var ref: DatabaseReference!
    
    init() {
        ref = Database.database().reference()
    }
    
    func createComment(author: String, description: String, postID: String) {
        let comment = Comment(authorName: author, description: description, id: nil, postID: postID)
        self.ref.child("Comments").child(comment.postID ).child("\(comment.id ?? UUID().uuidString)" ).setValue(comment.dictionaryRepresentation) { (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("Comment data could not be saved: \(error).")
                return
            } else {
                print("Comment data saved successfully!")
            }
        }
    }
    
    //returns an array of comments for specific postID
    func fetchCommentsforPost(postID: String, completion: @escaping ([Comment]?, Error?) -> Void) {
        var commentsForPost = [Comment]()
        guard let ref = self.ref else { return print("here1")}
        ref.child("Comments").child(postID).observeSingleEvent(of: .value) { (snapshot) in
            
            guard let comments = snapshot.value as? [String: Any] else {
                NSLog("Error printing authors")
                completion(nil, NSError())
                return
            }
            for c in comments {
                guard let comRep = c.value as? [String: Any],
                    let comment = Comment(dictionary: comRep) else { print("Trouble fetching comment data \(c)")
                        continue }
                commentsForPost.append(comment)
            }
            completion(commentsForPost, nil)
        }
    }
}
