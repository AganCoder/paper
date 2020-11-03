//
//  Array+Extension.swift
//  Paper
//
//  Created by Noah on 2020/11/2.
//  Copyright © 2020 Noah Gao. All rights reserved.
//

import Cocoa

extension Array {
    
    fileprivate var range: Range<Int> {
        return startIndex..<endIndex
    }

    public func object(at index: Int) -> Element? {
        guard range.contains(index) else {
            return nil
        }
        return self[index]
    }
}

