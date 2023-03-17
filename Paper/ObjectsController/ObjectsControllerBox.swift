//
//  ObjectsControllerBox.swift
//  Paper
//
//  Created by Noah.Gao on 2023/3/17.
//  Copyright © 2023 Noah Gao. All rights reserved.
//

import Foundation

open class ObjectsControllerBox<Base: ObjectsController>: AbstractObjectsController<Base.Object> {

    public typealias Object = Base.Object

    let base: Base

    public init(_ base: Base) {
        self.base = base
    }

    open override var objects: [Object] { return self.base.objects }

    open override var hasMore: Bool { return self.base.hasMore }

    open override func clearObjects() { self.base.clearObjects() }

    open override func reload(completion: @escaping ([Object]) -> Void, failure: @escaping (Error) -> Void) -> Bool {

        return self.base.reload(completion: completion, failure: failure)
    }

    open override func loadMore(completion: @escaping (_ inserted: [Object]) -> Void, failure: @escaping (Error) -> Void) -> Bool {

        return self.base.loadMore(completion: completion, failure: failure)
    }
}
