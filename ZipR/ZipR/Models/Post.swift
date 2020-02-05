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
    
    init(authorName: String, title: String, description: String, tag: [String] = [Tag.general.rawValue], long: Int = 0, lat: Int = 0, id: String?) {

        self.author = authorName
        self.title = title
        self.description = description
        self.tag = tag
        self.long = long
        self.lat = lat
        self.id = id == nil ? UUID().uuidString : id
    }
    
    convenience init?(dictionary: [String: Any]) {
        guard let author = dictionary["author"] as? String,
            let identifier = dictionary["id"] as? String,
            let description = dictionary["description"] as? String,
            let title = dictionary["title"] as? String,
            let latitude = dictionary["latitude"] as? Int,
            let longitude = dictionary["longitude"] as? Int else { return nil }


        if let tags = dictionary["tags"] as? [String] {
            self.init(authorName: author, title: title, description: description, tag: tags, long: longitude, lat: latitude, id: identifier)
            return
        }

        self.init(authorName: author, title: title, description: description, long: longitude, lat: latitude, id: identifier)
    }
    
    var dictionaryRepresentation: [String: Any] {
        return ["author": author, "title": title, "description": description, "tags": tag as Any, "id": id!, "latitude": lat ?? 0, "longitude": long ?? 0]
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
