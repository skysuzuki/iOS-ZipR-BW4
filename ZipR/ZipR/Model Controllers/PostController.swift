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
    
    func createPost(author: String, title: String, description: String, tag: [String], lat: String, long: String, date: String) {
        let post = Post(authorName: author, title: title, description: description, tag: tag, long: long, lat: lat, id: nil, date: date)
        //let post = Post(authorName: author, title: title, description: description, id: nil)
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
                NSLog("There are no posts in your area")
                return
            }
            for p in posts {
                guard let postRep = p.value as? [String: Any],
                    let post = Post(dictionary: postRep) else { print("Trouble fetching posts data")
                        continue }
                self.posts.append(post)
            }
            completion(nil)
        }
    }
    
    func deletePostandItsComments(postId: String) {
        self.ref.child("Posts").child(postId).removeValue()
        self.ref.child("Comments").child(postId).removeValue()
    }
    
    func parsePosts(lat: String, long: String) -> [Post] {
        var parsedPosts: [Post] = []
        var parsedPostsByDate: [Post] = []
        guard let usersLat = Double(lat),
            let usersLong = Double(long) else { return []}
        

        for post in posts {
            guard let latitude = post.lat, let longitude = post.long, let postLat = Double(latitude), let postLong = Double(longitude) else { return [] }
            if (postLat <= (usersLat + 1.0) && postLat >= (usersLat - 1.0)) && (postLong <= (usersLong + 1.0) && postLong >= (usersLong - 1.0))  {
                parsedPosts.append(post)
            }
        }
        parsedPostsByDate = orderPostsByDate(posts: parsedPosts)
        return parsedPostsByDate
    }
    
    func orderPostsByDate(posts: [Post]) -> [Post]{
        var orderedPosts: [Post] = []
        orderedPosts = posts.sorted(by: { Double($0.date)! > Double($1.date)! })
        
        return orderedPosts
    }
    
    func filterPostsByUserandDate(posts: [Post], userName: String) -> [Post]{
        var parsedPosts: [Post] = []
        
        let usersPosts = posts.filter({$0.author == userName})
        parsedPosts = orderPostsByDate(posts: usersPosts)
        
        return parsedPosts
    }
}
