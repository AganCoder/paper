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

    @IBOutlet weak var setWallPaperButton: NSButton! {
        didSet {
            setWallPaperButton.wantsLayer = true
            setWallPaperButton.layer?.cornerRadius = setWallPaperButton.bounds.height * 0.5
            setWallPaperButton.layer?.masksToBounds = true
        }
    }

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

        let attributedTitle = NSMutableAttributedString(string: self.authorLinkButton.title)
        let range = NSRange(location: 0, length: attributedTitle.length)
        attributedTitle.addAttribute(.foregroundColor,value: NSColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.3), range: range)

        setWallPaperButton.layer?.backgroundColor = NSColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor

        let point = self.convert(event.locationInWindow, from: nil)



        if setWallPaperButton.frame.contains(point) {
            setWallPaperButton.layer?.backgroundColor = NSColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        } else if authorLinkButton.frame.contains(point) {
            attributedTitle.addAttribute(.underlineColor, value: NSColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.3), range: range)
            attributedTitle.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        }

        self.authorLinkButton.attributedTitle = attributedTitle
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
