//
//  AbstractObjectsController.swift
//  Paper
//
//  Created by Noah on 2020/11/3.
//  Copyright © 2020 Noah Gao. All rights reserved.
//

import Foundation

open class AbstractObjectsController<Object>: NSObject, ObjectsController {

    public var objects: [Object] { return [] }

    public var hasMore: Bool { return false }

    public func clearObjects() { }

    public func reload(completion: @escaping ([Object]) -> Void, failure: @escaping (Error) -> Void) -> Bool { return false }

    public func loadMore(completion: @escaping (_ inserted: [Object]) -> Void, failure: @escaping (Error) -> Void) -> Bool { return false }
}
