//
//  User.swift
//  Paper
//
//  Created by Noah on 2020/9/29.
//  Copyright © 2020 Noah Gao. All rights reserved.
//

import Foundation

struct User {
    
    var id: String

    var userName: String

    var name: String

    var firstName: String

    var lastName: String

    var twitterName: String

    var bio: String?

    var location: String?

    var profileImage: [String: String] = [:]

    var links: [String: String] = [:]
}

extension User: Codable {
    
}
