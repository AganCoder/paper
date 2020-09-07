//
//  PaperTableCellView.swift
//  Paper
//
//  Created by Noah on 2020/9/4.
//  Copyright © 2020 Noah Gao. All rights reserved.
//

import Cocoa

class PaperTableCellView: NSTableCellView {

    @IBOutlet weak var backgroundImageView: NSImageView!
    @IBOutlet weak var setWallPaperButton: NSButton!
    @IBOutlet weak var authorLinkButton: NSButton!
    @IBOutlet weak var pixelIndicatorImageView: NSImageView!

    private var trackingArea: NSTrackingArea?

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }

    override func mouseEntered(with event: NSEvent) {
        self.setWallPaperButton.isHidden = false
        self.authorLinkButton.isHidden = false
        self.pixelIndicatorImageView.isHidden = false
    }

    override func mouseExited(with event: NSEvent) {
        self.setWallPaperButton.isHidden = true
        self.authorLinkButton.isHidden = true
        self.pixelIndicatorImageView.isHidden = true
    }

    override func mouseMoved(with event: NSEvent) {
        let point = self.convert(event.locationInWindow, from: nil)

        debugPrint(point)

        if setWallPaperButton.frame.contains(point) {
            debugPrint("点击了按钮")
        } else if authorLinkButton.frame.contains(point) {
            debugPrint("点击了link")
        }
    }

    override func updateTrackingAreas() {
        super.updateTrackingAreas()

        if trackingArea == nil {
            trackingArea = NSTrackingArea(rect: .zero, options: [.inVisibleRect, .activeAlways, .mouseEnteredAndExited, .mouseMoved], owner: self, userInfo: nil)
        }

        if let trackingArea = trackingArea, !self.trackingAreas.contains(trackingArea) {
            self.addTrackingArea(trackingArea)
        }
    }
}
