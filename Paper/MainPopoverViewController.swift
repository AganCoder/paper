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

    var controller = MainPopoverController()

    var lineView: NSView!

    private var cache: [TitleCategory: ImageTableViewController] = [:]

    private var currentController: ImageTableViewController?

    private var categoryStackView: NSStackView!

    override func loadView() {
        self.view = NSView()
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.main.cgColor
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()

        if let category = self.controller.selectedCategory {
            updateImageViewController(to: category)
        }

        self.controller.loadColumns { self.refreshCategoryView() }
    }

    private func updateImageViewController(to category: TitleCategory ) {

        guard self.controller.selectedCategory != category || self.currentController == nil else {
            return
        }

        self.controller.selectedCategory = category

        let controller = imageViewController(for: category)

        self.currentController?.removeFromParent()
        self.currentController?.view.removeFromSuperview()

        self.addChild(controller)
        self.view.addSubview(controller.view, positioned: .below, relativeTo: nil)
        controller.view.frame = self.view.bounds
        controller.view.autoresizingMask = [.width, .height]

        self.currentController = controller
    }

    private func refreshCategoryView() {

        for view in self.categoryStackView.subviews {
            self.categoryStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }

        for (index, category) in self.controller.categories.enumerated() {

            let btn = TitleButton(title: category.title, target: self, action: #selector(categoryButtonDidTapped(sender:)))
            btn.tag = index
            btn.isSelected = category == self.controller.selectedCategory

            self.categoryStackView.addArrangedSubview(btn)
        }

        self.categoryStackView.layoutSubtreeIfNeeded()

        updateLineViewConstrant()

        self.lineView.isHidden = false
    }

    func imageViewController(for category: TitleCategory) -> ImageTableViewController {

        if self.cache[category] == nil {

            let vc = ImageTableViewController()
            
            vc.controller = ImageTableController(category: category)

            self.cache[category] = vc
        }

        return self.cache[category]!
    }

    @objc func categoryButtonDidTapped(sender: TitleButton) {

        for view in self.categoryStackView.subviews {
            guard let btn = view as? TitleButton else {
                continue
            }
            btn.isSelected = btn == sender
        }

        updateLineViewConstrant()

        if let category = self.controller.categories.object(at: sender.tag) {
            updateImageViewController(to: category)
        }
    }

    private func updateLineViewConstrant() {
        for view in self.categoryStackView.subviews {
            if let btn = view as? TitleButton, btn.isSelected {
                let width: CGFloat = 24.0
                let frame = CGRect(x: btn.frame.midX - width / 2.0 , y: self.categoryStackView.frame.minY, width: width, height: 2)
                self.lineView.frame = frame
                break
            }
        }
    }
    
    @objc func settingButtonDidTapped(sender: NSButton) {
    }

    @objc func saveButtonDidTapped(sender: NSButton) {
        debugPrint("save")
    }

    @objc func reloadButtonDidTapped(sender: NSButton) {
        currentController?.reload()
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

        let lineView = NSView()
        lineView.wantsLayer = true
        lineView.layer?.backgroundColor = NSColor.white.cgColor
        lineView.isHidden = true
        self.lineView = lineView

        view.addSubview(brand)
        view.addSubview(setting)
        view.addSubview(save)
        view.addSubview(reload)
        view.addSubview(stackView)
        view.addSubview(lineView)

        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 285).isActive = true
        view.heightAnchor.constraint(equalToConstant: 600).isActive = true

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

        refreshCategoryView()
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


