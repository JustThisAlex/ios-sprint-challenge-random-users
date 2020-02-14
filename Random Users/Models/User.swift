//
//  User.swift
//  Random Users
//
//  Created by Alexander Supe on 14.02.20.
//  Copyright © 2020 Erica Sadun. All rights reserved.
//

import Foundation

struct Users: Decodable {
    let results: [User]
}

struct User: Decodable {
    let title: String
    let firstName: String
    let lastName: String
    let email: String
    let phone: String
    let thumbnail: URL
    let image: URL
    
    enum Keys: String, CodingKey {
        case name
        case email
        case phone
        case picture
        enum NameKeys: String, CodingKey {
            case title
            case firstName = "first"
            case lastName = "last"
        }
        enum PictureKeys: String, CodingKey {
            case thumbnail
            case image = "large"
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)

        let nameContainer = try container.nestedContainer(keyedBy: Keys.NameKeys.self, forKey: .name)
        title = try nameContainer.decode(String.self, forKey: .title)
        firstName = try nameContainer.decode(String.self, forKey: .firstName)
        lastName = try nameContainer.decode(String.self, forKey: .lastName)

        email = try container.decode(String.self, forKey: .email)
        phone = try container.decode(String.self, forKey: .phone)

        let pictureContainer = try container.nestedContainer(keyedBy: Keys.PictureKeys.self, forKey: .picture)
        thumbnail = try pictureContainer.decode(URL.self, forKey: .thumbnail)
        image = try pictureContainer.decode(URL.self, forKey: .image)
    }
}
