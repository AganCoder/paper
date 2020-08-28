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

    override func loadView() {
        self.view = NSView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()

        AF.request("https://service.paper.meiyuan.in/api/v2/columns").responseJSON { (response) in
            debugPrint(response)
        }
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

        let tableView = NSTableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .red

        view.addSubview(tableView)
        view.addSubview(brand)
        view.addSubview(setting)
        view.addSubview(save)
        view.addSubview(reload)

        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 285).isActive = true
        view.heightAnchor.constraint(equalToConstant: 600).isActive = true

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true

        brand.translatesAutoresizingMaskIntoConstraints = false
        brand.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        brand.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        brand.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        brand.heightAnchor.constraint(equalToConstant: 94).isActive = true

        save.translatesAutoresizingMaskIntoConstraints = false
        save.centerYAnchor.constraint(equalTo: brand.centerYAnchor).isActive = true
        save.rightAnchor.constraint(equalTo: setting.leftAnchor, constant: 0).isActive = true
        save.widthAnchor.constraint(equalToConstant: 32).isActive = true
        save.heightAnchor.constraint(equalToConstant: 32).isActive = true

        setting.translatesAutoresizingMaskIntoConstraints = false
        setting.centerYAnchor.constraint(equalTo: save.centerYAnchor).isActive = true
        setting.rightAnchor.constraint(equalTo: brand.rightAnchor, constant: -16).isActive = true
        setting.widthAnchor.constraint(equalToConstant: 32).isActive = true
        setting.heightAnchor.constraint(equalToConstant: 32).isActive = true

        reload.translatesAutoresizingMaskIntoConstraints = false
        reload.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        reload.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        reload.widthAnchor.constraint(equalToConstant: 50).isActive = true
        reload.heightAnchor.constraint(equalToConstant: 50).isActive = true

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
        self.view.layer?.backgroundColor = NSColor.background.cgColor
    }

}

extension MainPopoverViewController: NSTableViewDelegate {

}

extension MainPopoverViewController: NSTableViewDataSource {

    func numberOfRows(in tableView: NSTableView) -> Int {
        return 0
    }
}
