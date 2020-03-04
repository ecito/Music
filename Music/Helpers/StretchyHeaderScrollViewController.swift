//
//  StretchyHeaderScrollViewController.swift
//  Music
//
//  Created by Andre Navarro on 3/4/20.
//  Copyright © 2020 DML. All rights reserved.
//

import UIKit

/// View controller container with an imageview, title and tableview as content.
/// inspired by spotify (BLASPHEMY!)
class StretchyHeaderScrollViewController: UIViewController {
    var headerHeight: CGFloat
    
    lazy var headerImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = .black
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = .boldSystemFont(ofSize: 40)
        view.textAlignment = .center
        view.textColor = .white
        view.backgroundColor = .clear
        view.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        view.shadowOffset = CGSize(width: 1, height: 1)
        view.numberOfLines = 2
        return view
    }()
    
    var contentViewController: UIViewController
    var childTableView: UITableView
    private var didSetInitialFrames = false
    
    deinit {
        childTableView.removeObserver(self, forKeyPath: "contentOffset")
    }
    
    init(_ contentViewController: UIViewController, headerHeight: CGFloat = 400) {
        self.contentViewController = contentViewController
        self.headerHeight = headerHeight
        
        if !(contentViewController.view is UITableView) {
            fatalError("this container only works for view controllers with a scrollView as main view")
        }
        
        self.childTableView = contentViewController.view as! UITableView
        
        super.init(nibName: nil, bundle: nil)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black

        // set up header
        view.addSubview(headerImageView)
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: headerHeight))
        containerView.backgroundColor = .clear
        containerView.addSubview(titleLabel)
        childTableView.tableHeaderView = containerView
        
        // make a footerview so the image doesn't peek below 1 cell tables
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 200))
        footerView.backgroundColor = .black
        childTableView.tableFooterView = footerView
        
        // add content view
        addChild(contentViewController)
        view.addSubview(contentViewController.view)
        contentViewController.didMove(toParent: self)
        
        childTableView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // self.view.safeAreaInsets is not correct in viewDidLoad or viewWillAppear
        if !didSetInitialFrames {
            setFrames()
            didSetInitialFrames = true
        }
    }
        
    private func setFrames() {
        headerImageView.frame = CGRect(x: 0,
                                       y: self.view.safeAreaInsets.top,
                                       width: self.view.bounds.width,
                                       height: self.view.bounds.width)
        
        titleLabel.frame = CGRect(x: 0, y: headerHeight - 100, width: self.view.frame.width, height: 100)
        contentViewController.view.frame = view.bounds
    }
    
    override func observeValue(forKeyPath _: String?,
                               of _: Any?,
                               change : [NSKeyValueChangeKey: Any]?, context _: UnsafeMutableRawPointer?) {

        let tableViewYOffset = -childTableView.contentOffset.y - self.view.safeAreaInsets.top
        
        if tableViewYOffset > 0 {
            updateHeaderImageHeight(tableViewYOffset)
        }
        else {
            updateHeaderImageAlpha(tableViewYOffset)
        }
    }

    private func updateHeaderImageHeight(_ tableViewYOffset: CGFloat) {
        let originalHeight = self.view.bounds.width
        let height = originalHeight + tableViewYOffset
        headerImageView.frame = CGRect(x: 0, y: self.view.safeAreaInsets.top, width: self.view.bounds.width, height: height)
    }
    
    private func updateHeaderImageAlpha(_ tableViewYOffset: CGFloat) {
        if let tableHeaderViewHeight = childTableView.tableHeaderView?.frame.size.height,
            tableHeaderViewHeight > 0 {
            let alpha = -(-1 - (tableViewYOffset / tableHeaderViewHeight))
            if 0...1 ~= alpha {
                headerImageView.alpha = alpha
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
