//
//  MainPopoverViewController.swift
//  Paper
//
//  Created by Noah on 2020/8/9.
//  Copyright © 2020 Noah Gao. All rights reserved.
//

import Cocoa

class MainPopoverViewController: NSViewController {

    override func loadView() {
      self.view = NSView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func viewWillAppear() {
        super.viewWillAppear()

        // set triangle Part color
        if let superView = self.view.window?.contentView?.superview {
            superView.wantsLayer = true
            superView.layer?.backgroundColor = NSColor.purple.cgColor
        }

        // set background color
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.green.cgColor
    }

}
