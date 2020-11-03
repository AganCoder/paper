//
//  TitleButton.swift
//  Paper
//
//  Created by Noah on 2020/11/1.
//  Copyright © 2020 Noah Gao. All rights reserved.
//

import Cocoa

class TitleButton: NSButton {

    var isSelected = false {
        didSet {
            let attributedTitle = NSMutableAttributedString(string: self.title)
            let range = NSRange(location: 0, length: attributedTitle.length)
            attributedTitle.addAttribute(.foregroundColor, value: NSColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: isSelected ? 1.0 : 0.3), range: range)
            self.attributedTitle = attributedTitle
        }
    }

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)

        self.bezelStyle = .inline
        self.isBordered = false
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        self.bezelStyle = .inline
        self.isBordered = false
    }

}
