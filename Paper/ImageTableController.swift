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
            return "https://api.unsplash.com/photos?client_id=UxtTr6lOfauHu-Wk03HZfHZy9GIOHb7x54IStVRPwrU"
        case .custom(let column):
            return "https://service.paper.meiyuan.in/api/v2/columns/flow/\(column.id ?? "")"
        }
    }
}


class ImageTableController: PageLoadingObjectsController<Paper> {

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
        
        AF.request(self.category.url, parameters: parameters).responseDecodable(of: Papers.self) { response in
            if let values = response.value {
                completion(values)
            }
        }
        
        return true
    }
}   
