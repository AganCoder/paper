//
//  PageLoadingObjectsController.swift
//  Paper
//
//  Created by Noah.Gao on 2023/3/17.
//  Copyright © 2023 Noah Gao. All rights reserved.
//

import Foundation

open class PageLoadingObjectsController<Object>: PageOffsetBasedObjectsController<Object> {
    
    public override init() {
        super.init()
    }
    
    var _requesting: Bool = false

    internal(set) open var requesting: Bool {
        get {
            objc_sync_enter(self)

            defer {
                objc_sync_exit(self)
            }

            return self._requesting
        }
        set {
            objc_sync_enter(self)

            defer {
                objc_sync_exit(self)
            }

            self._requesting = newValue
        }
    }
    
    open override func reload(completion: @escaping ([Object]) -> Void, failure: @escaping (Error) -> Void) -> Bool {

        guard !self.requesting else { return false }

        let processing = super.reload(completion: { (objects) -> Void in
            self.requesting = false
            completion(objects)
        }, failure: { (error) -> Void in
            self.requesting = false
            failure(error)
        })

        if processing {
            self.requesting = true
        }

        return processing
    }

    open override func loadMore(completion: @escaping (_ inserted: [Object]) -> Void, failure: @escaping (Error) -> Void) -> Bool {

        guard !self.requesting else { return false }

        let processing = super.loadMore(completion: { (inserted) -> Void in
            self.requesting = false
            completion(inserted)
        }, failure: { (error) -> Void in
            self.requesting = false
            failure(error)
        })

        if processing {
            self.requesting = true
        }

        return processing
    }
}
