//
//  MessageBoard.swift
//  ZipR
//
//  Created by Dennis Rudolph on 2/3/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class Post: Codable {
    
    let author: String
    let title: String
    let description: String
    let tag: [Tag.RawValue]?
    let long: Int?
    let lat: Int?
    let id: String?
    
    init(authorName: String, title: String, description: String, tag: [Tag] = [Tag.general], long: Int = 0, lat: Int = 0, id: String?) {
        var tagRaw: [String] = []
        for i in tag {
            tagRaw.append(i.rawValue)
        }
        self.author = authorName
        self.title = title
        self.description = description
        self.tag = tagRaw
        self.long = long
        self.lat = lat
        self.id = UUID().uuidString
    }
    
    convenience init?(dictionary: [String: Any]) {
        guard let author = dictionary["author"] as? String,
            let identifier = dictionary["id"] as? String,
            let description = dictionary["description"] as? String,
            let title = dictionary["title"] as? String else { return nil }
        self.init(authorName: author, title: title, description: description, id: identifier)
    }
    
    var dictionaryRepresentation: [String: Any] {
        return ["author": author, "title": title, "description": description, "id": id!]
      }
}









enum Tag: String, CaseIterable {
    case general
    case art
    case news
    case videogames
    case sports
    case food
}

struct User {
    let username: String
    let password: String
    let id: UUID
}
