//
//  ObjectsControllerBase.swift
//  Paper
//
//  Created by Noah on 2020/11/3.
//  Copyright © 2020 Noah Gao. All rights reserved.
//

import Foundation

open class ObjectsControllerBase<Object>: AbstractObjectsController<Object> {

    fileprivate var _objects: [Object] = []

    open override var objects: [Object] {
        get {
            return self._objects
        }
        set {
            self._objects = newValue
        }
    }

    fileprivate var _hasMore: Bool = true

    internal(set) open override var hasMore: Bool {
        get {
            return self._hasMore
        }
        set {
            self._hasMore = newValue
        }
    }

    public override init() {
        super.init()
    }

    open override func clearObjects() {
        self.objects = []
        self.hasMore = true
    }
}
