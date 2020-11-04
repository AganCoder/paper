//
//  ImageTableController.swift
//  Paper
//
//  Created by Noah on 2020/11/3.
//  Copyright © 2020 Noah Gao. All rights reserved.
//

import Cocoa
import Alamofire

fileprivate extension TitleCategory {

    var url: String {
        switch self {
        case .new, .hot:
            return "https://api.unsplash.com/photos?client_id=1c0018090c0878f9556fba12d4b8ba060866de2733de1cc8486c720bf7c9a04e"
        case .custom(let column):
            return "https://service.paper.meiyuan.in/api/v2/columns/flow/\(column.id ?? "")"
        }
    }
}


class ImageTableController: PageOffsetBasedObjectsController<Paper> {

    var column: Column?

    let category: TitleCategory

    var images: [Paper] {
        return self.objects
    }

    init(category: TitleCategory) {

        self.category = category

        super.init()
    }

    @discardableResult
    open override func loadObjects(currentPage index: Int, pageSize: Int, completion: @escaping (([Paper]) -> Void), failure: @escaping (Error) -> Void) -> Bool {

        var parameters: Parameters = [:]
        parameters["page"] = index
        parameters["per_page"] = pageSize

        switch self.category {
        case .new:
            parameters["order_by"] = "latest"

        case .hot:
            parameters["order_by"] = "popular"

        case .custom:
            break
        }

        AF.request(self.category.url, parameters: parameters).responseJSON { (response) in

            guard let data = response.data, response.error == nil else {
                failure(response.error!)
                return
            }

            if case let .success(objects) = Result(catching: { try JSONDecoder().decode(Papers.self, from: data) }) {
                self.objects = objects
                completion(objects)
            }
        }

        return true
    }
}   
