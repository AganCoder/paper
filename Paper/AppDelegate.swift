//
//  AppDelegate.swift
//  Paper
//
//  Created by Noah on 2020/8/6.
//  Copyright © 2020 Noah Gao. All rights reserved.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)

    let popover = NSPopover()

    func applicationDidFinishLaunching(_ aNotification: Notification) {

        let icon = NSImage(named: NSImage.Name("icon16*16"))
        icon?.isTemplate = true
        
        statusItem.button?.image = icon    
        statusItem.button?.target = self
        statusItem.button?.action = #selector(onStatusItemDidClicked(_:))

        popover.behavior = .semitransient
        popover.animates = true
        popover.contentSize = CGSize(width: 285, height: 600)
        popover.contentViewController = MainPopoverViewController()

        NSEvent.addGlobalMonitorForEvents(matching: [.leftMouseUp, .rightMouseUp] ) { [weak self] _ in
            if let isShown = self?.popover.isShown, isShown {
                self?.popover.close()
            }
        }
    }

    @objc private func onStatusItemDidClicked(_ statusBarButton: NSStatusBarButton) {
        if !self.popover.isShown {
            self.popover.show(relativeTo: statusBarButton.bounds, of: statusBarButton, preferredEdge: .minY)
        } else {
            self.popover.close()
        }
    }

    func applicationWillResignActive(_ notification: Notification) {
        if self.popover.isShown {
            self.popover.close()
        }
    }
}

