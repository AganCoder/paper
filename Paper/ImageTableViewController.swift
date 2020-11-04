//
//  ImageTableViewController.swift
//  Paper
//
//  Created by Noah on 2020/11/3.
//  Copyright © 2020 Noah Gao. All rights reserved.
//

import Cocoa

class ImageTableViewController: NSViewController {

    var controller: ImageTableController?

    var tableView: NSTableView!

    override func loadView() {
        self.view = NSView()
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

        self.tableView = tableView
        view.addSubview(scrollView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true

        _ = self.controller?.reload(completion: { _ in
            self.tableView.reloadData()
        }, failure: { error in
            debugPrint("error")
        })
    }
}

extension ImageTableViewController: NSTableViewDelegate, NSTableViewDataSource {

    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.controller?.objects.count ?? 0
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {

        if let cellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("PaperTableCellView"), owner: self) as? PaperTableCellView {
            cellView.paper = self.controller?.objects[row]

            return cellView
        }
        return NSView()
    }

    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 168.0
    }

    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return false
    }
}
