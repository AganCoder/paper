//
//  Paper.swift
//  Paper
//
//  Created by Noah on 2020/9/29.
//  Copyright © 2020 Noah Gao. All rights reserved.
//

import Foundation

typealias Papers = [Paper]

enum Stype: String, Codable {
    case standard
    case is4K = "4K"
    case is5K = "5K"
}

struct Paper: Identifiable {

    var id: String?

    var width: Double?

    var height: Double?

    var color: String?

    var desc: String?

    var likes: Int?

    var download: Int?

    var from: String?

    var stype: Stype?

    var urls: [String: String]? = [:]

    var links: [String: String]? = [:]

    var user: User?

    var addedDate: String?

    var createdDate: String?

    var updatedDate: String?
}


extension Paper: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case width
        case height
        case color
        case desc
        case likes
        case download
        case from
        case stype
        case urls
        case links
        case user
        case addedDate
        case createdDate
        case updatedDate
    }

    public init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container?.decode(String.self, forKey: .id)
        self.width = try? container?.decode(Double.self, forKey: .width)
        self.height = try? container?.decode(Double.self, forKey: .height)
        self.color = try? container?.decode(String.self, forKey: .color)
        self.likes = try? container?.decode(Int.self, forKey: .likes)
        self.download = try? container?.decode(Int.self, forKey: .download)
        self.from = try? container?.decode(String.self, forKey: .from)
        self.stype = try? container?.decode(Stype.self, forKey: .stype)
        self.urls = try? container?.decode([String: String].self, forKey: .urls)
        self.links = try? container?.decode([String: String].self, forKey: .links)
        self.user = try? container?.decode(User.self, forKey: .user)
        self.addedDate = try? container?.decode(String.self, forKey: .addedDate)
        self.createdDate = try? container?.decode(String.self, forKey: .createdDate)
        self.updatedDate = try? container?.decode(String.self, forKey: .updatedDate)
    }

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(self.id, forKey: .id)
        try? container.encode(self.width, forKey: .width)
        try? container.encode(self.height, forKey: .height)
        try? container.encode(self.color, forKey: .color)
        try? container.encode(self.likes, forKey: .likes)
        try? container.encode(self.download, forKey: .download)
        try? container.encode(self.from, forKey: .from)
        try? container.encode(self.stype, forKey: .stype)
        try? container.encode(self.urls, forKey: .urls)
        try? container.encode(self.links, forKey: .links)
        try? container.encode(self.user, forKey: .user)
        try? container.encode(self.addedDate, forKey: .addedDate)
        try? container.encode(self.createdDate, forKey: .createdDate)
        try? container.encode(self.updatedDate, forKey: .updatedDate)
    }
}

extension Paper: Equatable {
    public static func == (lhs: Paper, rhs: Paper) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Paper: CustomStringConvertible, CustomDebugStringConvertible {

    public var description: String {
        return self.debugDescription
    }

    public var debugDescription: String {

        return "id: \(id ?? ""), urls: \(urls ?? [:]), user: \(String(describing: user))"
    }
}
