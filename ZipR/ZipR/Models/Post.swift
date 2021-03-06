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
    let long: String?
    let lat: String?
    let id: String?
    let date: String
    
    init(authorName: String, title: String, description: String, tag: [String] = [Tag.general.rawValue], long: String = "", lat: String = "", id: String?, date: String) {
    
        self.author = authorName
        self.title = title
        self.description = description
        self.tag = tag
        self.long = long
        self.lat = lat
        self.id = id == nil ? UUID().uuidString : id
        self.date = date
    }
    
    convenience init?(dictionary: [String: Any]) {
        guard let author = dictionary["author"] as? String,
            let identifier = dictionary["id"] as? String,
            let description = dictionary["description"] as? String,
            let title = dictionary["title"] as? String,
            let latitude = dictionary["latitude"] as? String,
            let longitude = dictionary["longitude"] as? String else { return nil }

        let date = dictionary["date"] as? String
        if let tags = dictionary["tags"] as? [String] {
            self.init(authorName: author, title: title, description: description, tag: tags, long: longitude, lat: latitude, id: identifier, date: date ?? "")
            return
        }

        self.init(authorName: author, title: title, description: description, long: longitude, lat: latitude, id: identifier, date: date ?? "")
    }
    
    var dictionaryRepresentation: [String: Any] {
        return ["author": author, "title": title, "description": description, "tags": tag as Any, "id": id!, "latitude": lat ?? "", "longitude": long ?? "", "date": date]
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
