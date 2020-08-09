//
//  AppDelegate.swift
//  Paper
//
//  Created by Noah on 2020/8/6.
//  Copyright © 2020 Noah Gao. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {


    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)

    let popover = NSPopover()

    func applicationDidFinishLaunching(_ aNotification: Notification) {

        let icon = NSImage(named: NSImage.Name("icon16*16"))
        icon?.isTemplate = true

        statusItem.image = icon
        statusItem.button?.target = self
        statusItem.button?.action = #selector(onStatusItemDidClicked(_:))

        popover.behavior = .transient
        popover.animates = true
        popover.contentSize = CGSize(width: 285, height: 600)
        popover.contentViewController =  MainPopoverViewController()

    }

    @objc private func onStatusItemDidClicked(_ statusBarButton: NSStatusBarButton) {

        debugPrint(#function)

        if !self.popover.isShown {
            self.popover.show(relativeTo: statusBarButton.bounds, of: statusBarButton, preferredEdge: .minY)
        }
    }
}

