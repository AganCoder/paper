//
//  Column.swift
//  Paper
//
//  Created by Noah on 2020/8/28.
//  Copyright © 2020 Noah Gao. All rights reserved.
//

import Foundation

typealias Columns = [Column]

public enum Lang: String, Codable {
    case en = "en"
    case zhHans = "zh-hans-CN"
    case zhHant = "zh-hant"
}


public struct Column: Identifiable {

    public var id: String?

    public var title: String?

    public var available: Bool?

    public var langs: [Lang: String]?

    public var unsplashID: String?

    public var v: Int?

    public var isDefault = false

    static let hot: Column = {
        var h = Column()
        h.id = "popular"
        h.title = "Hot"
        h.available = true
        h.isDefault = true
        return h
    }()

    static let new: Column = {
        var n = Column()
        n.id = "latest"
        n.title = "New"
        n.available = true
        n.isDefault = true
        return n
    }()
}

extension Column: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case available
        case langs
        case unsplashID = "unsplash_id"
        case v = "__v"
    }

    public init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container?.decode(String.self, forKey: .id)
        self.title = try? container?.decode(String.self, forKey: .title)
        self.available = try? container?.decode(Bool.self, forKey: .available)
        self.langs = try? container?.decode([Lang: String].self, forKey: .langs)
        self.unsplashID = try? container?.decode(String.self, forKey: .unsplashID)
        self.v = try? container?.decode(Int.self, forKey: .v)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(self.id, forKey: .id)
        try? container.encode(self.title, forKey: .title)
        try? container.encode(self.available, forKey: .available)
        try? container.encode(self.langs, forKey: .langs)
        try? container.encode(self.unsplashID, forKey: .unsplashID)
        try? container.encode(self.v, forKey: .v)
    }
}

extension Column: Equatable {
    public static func == (lhs: Column, rhs: Column) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Column: CustomStringConvertible, CustomDebugStringConvertible {

    public var description: String {
        return self.debugDescription
    }

    public var debugDescription: String {
        return "id: \(id ?? ""), title: \(title ?? ""), available: \(available ?? false )"
    }
}
