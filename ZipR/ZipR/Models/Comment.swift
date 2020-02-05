//
//  Comment.swift
//  ZipR
//
//  Created by Dennis Rudolph on 2/4/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class Comment: Codable {
    let author: String
    let description: String
    let id: String?
    let postID: String
    
    init(authorName: String, description: String, id: String?, postID: String) {
        self.author = authorName
        self.description = description
        self.id = UUID().uuidString
        self.postID = postID
    }
    
    convenience init?(dictionary: [String: Any]) {
        guard let author = dictionary["author"] as? String,
            let identifier = dictionary["id"] as? String,
            let description = dictionary["description"] as? String,
            let postID = dictionary["postID"] as? String else { return nil }
        self.init(authorName: author, description: description, id: identifier, postID: postID)
    }
    
    var dictionaryRepresentation: [String: Any] {
        return ["author": author, "description": description, "id": id!, "postID": postID]
      }
}
