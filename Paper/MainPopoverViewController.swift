//
//  MainPopoverViewController.swift
//  Paper
//
//  Created by Noah on 2020/8/9.
//  Copyright © 2020 Noah Gao. All rights reserved.
//

import Cocoa
import Alamofire
import Kingfisher

class MainPopoverViewController: NSViewController {

    var columns: Columns = [] {
        didSet {
            if self.columns != oldValue {
                self.refreshCategoryView()
            }
        }
    }

    private var categoryStackView: NSStackView!

    override func loadView() {
        self.view = NSView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()

        AF.request("https://service.paper.meiyuan.in/api/v2/columns").responseJSON { (response) in
            guard let data = response.data, response.error == nil else {
                return
            }
            let decoder = JSONDecoder()
            if case let .success(columns) = Result(catching: { try decoder.decode(Columns.self, from: data) }) {
                self.columns = columns.filter { $0.available ?? false }
            }
        }
    }

    private func refreshCategoryView() {
        debugPrint(#function)

        // first remove exist arrangedSubView
        for view in self.categoryStackView.subviews {
            self.categoryStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }

        for (index, value) in self.columns.enumerated() where value.available ?? false {
            let btn = NSButton(title: value.title!, target: self, action: #selector(categoryButtonDidTapped(sender:)))
            btn.tag = index
            self.categoryStackView .addArrangedSubview(btn)
        }
    }

    @objc func categoryButtonDidTapped(sender: NSButton) {
        debugPrint(sender.tag)
    }

    @objc func settingButtonDidTapped(sender: NSButton) {
        debugPrint("setting")
    }

    @objc func saveButtonDidTapped(sender: NSButton) {
        debugPrint("save")
    }

    @objc func reloadButtonDidTapped(sender: NSButton) {
        debugPrint("reload")
    }

    private func initSubviews() {

        let brand = NSImageView(image: NSImage(named: "newheader280x94")!)
        brand.imageScaling = .scaleAxesIndependently

        let save = NSButton(image: NSImage(named: "saved-icon16x16")!, target: self, action: #selector(saveButtonDidTapped(sender:)))
        save.setButtonType(NSButton.ButtonType.pushOnPushOff)
        save.bezelStyle = .rounded
        save.isBordered = false

        let setting = NSButton(image: NSImage(named: "Settings16x16")!, target: self, action: #selector(settingButtonDidTapped(sender:)))
        setting.setButtonType(NSButton.ButtonType.pushOnPushOff)
        setting.bezelStyle = .rounded
        setting.isBordered = false

        let reload = NSButton(image: NSImage(named: "reload_button40x40")!, target: self, action: #selector(reloadButtonDidTapped(sender:)))
        reload.setButtonType(NSButton.ButtonType.pushOnPushOff)
        reload.bezelStyle = .rounded
        reload.isBordered = false

        let stackView = NSStackView()
        stackView.alignment = .centerY
        stackView.orientation = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing    = 10
        self.categoryStackView = stackView

        let scrollView = NSScrollView()

        let tableView = NSTableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = NSColor.main
        tableView.register(NSNib(nibNamed: "PaperTableCellView", bundle: nil), forIdentifier: NSUserInterfaceItemIdentifier(rawValue: "PaperTableCellView"))
        tableView.headerView = nil

        let column = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "rsenjoyer.github.io.Paper"))

        tableView.addTableColumn(column)

        scrollView.documentView = tableView

        view.addSubview(scrollView)
        view.addSubview(brand)
        view.addSubview(setting)
        view.addSubview(save)
        view.addSubview(reload)
        view.addSubview(stackView)

        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 285).isActive = true
        view.heightAnchor.constraint(equalToConstant: 600).isActive = true

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true

        brand.translatesAutoresizingMaskIntoConstraints = false
        brand.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        brand.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        brand.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        brand.heightAnchor.constraint(equalToConstant: 94).isActive = true

        save.translatesAutoresizingMaskIntoConstraints = false
        save.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        save.rightAnchor.constraint(equalTo: setting.leftAnchor, constant: 0).isActive = true
        save.widthAnchor.constraint(equalToConstant: 32).isActive = true
        save.heightAnchor.constraint(equalToConstant: 32).isActive = true

        setting.translatesAutoresizingMaskIntoConstraints = false
        setting.centerYAnchor.constraint(equalTo: save.centerYAnchor).isActive = true
        setting.rightAnchor.constraint(equalTo: brand.rightAnchor, constant: -10).isActive = true
        setting.widthAnchor.constraint(equalToConstant: 32).isActive = true
        setting.heightAnchor.constraint(equalToConstant: 32).isActive = true

        reload.translatesAutoresizingMaskIntoConstraints = false
        reload.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        reload.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        reload.widthAnchor.constraint(equalToConstant: 50).isActive = true
        reload.heightAnchor.constraint(equalToConstant: 50).isActive = true

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leftAnchor.constraint(equalTo: brand.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: brand.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: brand.bottomAnchor, constant: -4).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }

    override func viewWillAppear() {
        super.viewWillAppear()

        // set triangle Part color
        if let superView = self.view.window?.contentView?.superview {
            superView.wantsLayer = true
            superView.layer?.backgroundColor = NSColor.main.cgColor
        }

        // set background color
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.main.cgColor
    }

}

extension MainPopoverViewController: NSTableViewDelegate, NSTableViewDataSource {

    func numberOfRows(in tableView: NSTableView) -> Int {
        return 10
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {

        if let cellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("PaperTableCellView"), owner: self) {
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
