//
//  ObjectsController.swift
//  Paper
//
//  Created by Noah on 2020/11/3.
//  Copyright © 2020 Noah Gao. All rights reserved.
//

import Foundation

public protocol ObjectsController {

    associatedtype Object

    var objects: [Object] { get }

    var hasMore: Bool { get }

    func clearObjects()

    func reload(completion: @escaping ([Object]) -> Void, failure: @escaping (Error) -> Void) -> Bool

    func loadMore(completion: @escaping (_ inserted: [Object]) -> Void, failure: @escaping (Error) -> Void) -> Bool
}
