//
//  ImageTableController.swift
//  Paper
//
//  Created by Noah on 2020/11/3.
//  Copyright © 2020 Noah Gao. All rights reserved.
//

import Cocoa
import Alamofire

class ImageTableController: NSObject {

    var column: Column?

    let category: TitleCategory

    var images: [Paper] = []

    init(category: TitleCategory) {
        self.category = category

        super.init()
    }

    @discardableResult
    func loadImages(success: @escaping([Paper]) -> Void, failure: Failure? = nil) -> Bool {

        AF.request("https://service.paper.meiyuan.in/api/v2/columns/flow/5efb6009ae089fd1b96ded19?page=1&per_page=20").responseJSON { (response) in
            guard let data = response.data, response.error == nil else {
                failure?(response.error!)
                return
            }

            if case let .success(images) = Result(catching: { try JSONDecoder().decode(Papers.self, from: data) }) {
                self.images = images

                success(self.images)
            }
        }

        return true
    }
}   
