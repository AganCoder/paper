//
//  MainPopoverController.swift
//  Paper
//
//  Created by Noah on 2020/11/3.
//  Copyright © 2020 Noah Gao. All rights reserved.
//

import Cocoa
import Alamofire

typealias Complete = () -> Void

typealias Failure = (Error) -> Void


enum TitleCategory {
    case new
    case hot
    case custom(title: String)
}

extension TitleCategory {
    var title: String {
        switch self {
        case .new:
            return "New"
        case .hot:
            return "Hot"
        case .custom(let title):
            return title
        }
    }
}

extension TitleCategory: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.title)
    }
}

extension TitleCategory: Equatable {
    static func == (lhs: TitleCategory, rhs: TitleCategory) -> Bool {
        return lhs.title == rhs.title
    }
}

extension TitleCategory {
    init?(column: Column?) {
        guard let column = column, let title = column.title else { return nil }

        self = .custom(title: title)
    }
}


class MainPopoverController: NSObject {

    var columns: Columns = []

    var categories: [TitleCategory] = [.new, .hot] {
        didSet {
            guard let first = self.categories.first, first != self.selectedCategory else {
                return
            }
            self.selectedCategory = first
        }
    }

    var selectedCategory: TitleCategory?

    override init() {
        super.init()

        self.selectedCategory = self.categories.first
    }

    @discardableResult
    func loadColumns(completion: @escaping Complete, failure: Failure? = nil ) -> Bool {

        AF.request("https://service.paper.meiyuan.in/api/v2/columns").responseJSON { (response) in
            guard let data = response.data, response.error == nil else {
                failure?( response.error! )
                return
            }

            if case let .success(columns) = Result(catching: { try JSONDecoder().decode(Columns.self, from: data) }) {
                self.columns = columns.filter { $0.available ?? false }
                self.categories = columns.compactMap { TitleCategory(column: $0) }

                self.selectedCategory = self.categories.first
            }

            completion()
        }
        return false
    }

}
