//
//  ImageTableViewController.swift
//  Paper
//
//  Created by Noah on 2020/11/3.
//  Copyright © 2020 Noah Gao. All rights reserved.
//

import Cocoa
import Kingfisher

class ImageTableViewController: NSViewController {

    var controller: ImageTableController?

    var tableView: NSTableView!

    override func loadView() {
        self.view = NSView()
    }
    
    func reload() {
        _ = self.controller?.reload(completion: { _ in
            self.tableView.reloadData()
        }, failure: { error in
            debugPrint("error")
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let tableView = NSTableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = NSColor.background
        tableView.register(NSNib(nibNamed: "PaperTableCellView", bundle: nil), forIdentifier: NSUserInterfaceItemIdentifier(rawValue: "PaperTableCellView"))
        tableView.headerView = nil
        let column = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "gnoah89.github.io.Paper"))
        tableView.addTableColumn(column)

        let scrollView = NSScrollView()
        scrollView.backgroundColor = NSColor.background
        scrollView.documentView = tableView
        scrollView.automaticallyAdjustsContentInsets = false
        scrollView.contentInsets = NSEdgeInsets(top: 94, left: 0, bottom: 0, right: 0)
        scrollView.contentView.postsBoundsChangedNotifications = true
        scrollView.hasVerticalScroller = true

        self.tableView = tableView
        view.addSubview(scrollView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(boundsDidChangeNotification), name: NSView.boundsDidChangeNotification, object: nil)

        reload()
    }
    
    @objc func boundsDidChangeNotification() {
        if let scrollView = tableView.enclosingScrollView {
            let clipView = scrollView.contentView
            let documentVisibleRect = clipView.documentVisibleRect
            let lastRowRect = tableView.rect(ofRow: tableView.numberOfRows - 1)
            if documentVisibleRect.contains(lastRowRect) {
                let _ = self.controller?.loadMore(completion: { inserted in
                    self.tableView.reloadData()
                }, failure: { error in
                    debugPrint(error)
                })
            }
        }
    }
}


extension ImageTableViewController: NSTableViewDelegate, NSTableViewDataSource, PaperTableCellViewDelegate {

    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.controller?.objects.count ?? 0
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        guard let cellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("PaperTableCellView"), owner: self) as? PaperTableCellView else {
            return nil
        }
        
        cellView.paper = self.controller?.objects[row]
        cellView.delegate = self
        
        return cellView
    }

    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 168.0
    }

    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return false
    }
    
    func onSetWallPaperButton(in view: PaperTableCellView) {
        guard let downloadUrl = view.paper?.downloadUrl, let url = URL(string: downloadUrl) else {
            return
        }
        let source = ImageResource(downloadURL: url)
        
        KingfisherManager.shared.retrieveImage(with: source) { result in
            
            switch result {
            case .success(let value):
                
                let urlComponent = URLComponents(string: value.source.url!.absoluteString)
                guard let fileName = urlComponent?.path.split(separator: "/").object(at: 1) else {
                    return
                }
                let key = String( fileName )
                
                guard let pictureFolder = FileManager.default.urls(for: .picturesDirectory, in: .userDomainMask).first else {
                    return
                }
                
                let paperFolder = pictureFolder.appendingPathComponent("Paper", isDirectory: true)
                try? FileManager.default.createDirectory(at: paperFolder, withIntermediateDirectories: true)
                
                let image = value.image
                let imageFileUrl = paperFolder.appendingPathComponent("\(key).jpg")
                try? FileManager.default.removeItem(atPath: imageFileUrl.absoluteString)
                
                // 将 NSImage 写入到图片文件中
                if let data = image.tiffRepresentation, let imageRep = NSBitmapImageRep(data: data) {
                    let properties: [NSBitmapImageRep.PropertyKey: Any] = [.compressionFactor: 1.0]
                    if let imageData = imageRep.representation(using: .jpeg, properties: properties) {
                        try? imageData.write(to: imageFileUrl)
                    }
                }
                        
                let workspace = NSWorkspace.shared
                guard let mainScreen = NSScreen.main, var options = workspace.desktopImageOptions(for: mainScreen) else {
                    return
                }
                guard let url = workspace.desktopImageURL(for: mainScreen) else {
                    return
                }
                
                options[.imageScaling] = NSImageScaling.scaleProportionallyUpOrDown.rawValue
                options[.allowClipping] = true
                try? workspace.setDesktopImageURL(imageFileUrl, for: mainScreen, options: options)
                
                break
            case .failure(let error):
                print("Error \(error)")
            }
        }
    }
}
