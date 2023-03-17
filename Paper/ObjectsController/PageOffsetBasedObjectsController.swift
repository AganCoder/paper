//
//  PageOffsetBasedObjectsController.swift
//  Paper
//
//  Created by Noah on 2020/11/3.
//  Copyright © 2020 Noah Gao. All rights reserved.
//

import Foundation

open class PageOffsetBasedObjectsController<Object>: ObjectsControllerBase<Object> {

    public override init() {
        super.init()
    }

    fileprivate var currentPage: Int = 1

    open var pageSize: Int = 20

    private func loadObjectAndCheckMore(currentPage index: Int, pageSize: Int, completion: @escaping ([Object], Bool) -> Void, failure: @escaping (Error) -> Void) -> Bool {

        return self.loadObjects(currentPage: index, pageSize: pageSize, completion: { [self] (objects) -> Void in
            
            self.currentPage = index
            
            let hasMore = objects.count >= pageSize
            
            completion(objects, hasMore)

        }, failure: failure)
    }

    open func loadObjects(currentPage index: Int, pageSize: Int, completion: @escaping (([Object]) -> Void), failure: @escaping (Error) -> Void) -> Bool {

        fatalError("Not Implemented")
    }

    open override func reload(completion: @escaping ([Object]) -> Void, failure: @escaping (Error) -> Void) -> Bool {

        return loadObjectAndCheckMore(currentPage: 1, pageSize: self.pageSize, completion: { (objects, hasMore) -> Void in

            self.objects = objects
            self.hasMore = hasMore

            completion(objects)

            }, failure: failure)
    }

    open override func loadMore(completion: @escaping (_ inserted: [Object]) -> Void, failure: @escaping (Error) -> Void) -> Bool {

        if !self.hasMore {
            return false
        }

        return self.loadObjectAndCheckMore(currentPage: self.currentPage + 1, pageSize: pageSize,  completion: { (objects, hasMore) -> Void in

            self.objects.append(contentsOf: objects)

            self.hasMore = hasMore

            completion(objects)

        }, failure: failure)
    }
}
