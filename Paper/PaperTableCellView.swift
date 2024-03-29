//
//  PaperTableCellView.swift
//  Paper
//
//  Created by Noah on 2020/9/4.
//  Copyright © 2020 Noah Gao. All rights reserved.
//

import Cocoa
import Kingfisher

extension Paper.Stype {

    var imageName: NSImage? {
        switch self {
        case .standard:
            return nil
        case .is4K:
            return NSImage(named: NSImage.Name("4k_icon_normal24x24"))
        case .is5K:
            return NSImage(named: NSImage.Name("5k_icon_normal24x24"))
        }
    }
}

extension Paper {

    var thumbUrl:String {
        guard let thumb = self.urls?["thumb"] else {
            return ""
        }
        return thumb
    }
    
    var downloadUrl: String {
        guard let download = self.links?["download"] else {
            return ""
        }
        return download
    }
}

protocol PaperTableCellViewDelegate: AnyObject {
    func onSetWallPaperButton(in view: PaperTableCellView)
}

class PaperTableCellView: NSTableCellView {
    
    weak var delegate: PaperTableCellViewDelegate?
    
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

    private func mouseEvent(for isEntered: Bool) {
        self.setWallPaperButton.isHidden = !isEntered
        self.authorLinkButton.isHidden = !isEntered
        self.pixelIndicatorImageView.isHidden = !isEntered
    }

    var paper: Paper? {
        didSet {
            if let urlString = paper?.thumbUrl, let url = URL(string: urlString) {
                self.backgroundImageView.kf.setImage(with: url)
            } else {
                self.backgroundImageView.image = nil
            }
        }
    }

    @IBAction func onSetWallPagerButton(_ sender: NSButton!) {
        delegate?.onSetWallPaperButton(in: self)
    }
    
    override func mouseEntered(with event: NSEvent) {
        mouseEvent(for: true)
    }

    override func mouseExited(with event: NSEvent) {
        mouseEvent(for: false)
    }

    override func mouseMoved(with event: NSEvent) {

        func mouseHoverAtSetWallPaperButton(at point: CGPoint) {

            if setWallPaperButton.frame.contains(point) {
                setWallPaperButton.layer?.backgroundColor = NSColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
            } else {
                setWallPaperButton.layer?.backgroundColor = NSColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
            }
        }

        func mouseHoverAtAuthorLinkButton(at point: CGPoint) {

            let attributedTitle = NSMutableAttributedString(string: self.authorLinkButton.title)
            let range = NSRange(location: 0, length: attributedTitle.length)
            attributedTitle.addAttribute(.foregroundColor, value: NSColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.3), range: range)

            if authorLinkButton.frame.contains(point) {
                attributedTitle.addAttribute(.underlineColor, value: NSColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.3), range: range)
                attributedTitle.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
            }

            self.authorLinkButton.attributedTitle = attributedTitle
        }

        let point = self.convert(event.locationInWindow, from: nil)
        mouseHoverAtSetWallPaperButton(at: point)
        mouseHoverAtAuthorLinkButton(at: point)
    }

    override func updateTrackingAreas() {
        super.updateTrackingAreas()

        let trackingArea = NSTrackingArea(rect: self.frame, options: [.mouseEnteredAndExited, .activeAlways], owner: self, userInfo: nil)
        if !self.trackingAreas.contains(trackingArea) {
            self.addTrackingArea(trackingArea)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.paper = nil
    }
}
