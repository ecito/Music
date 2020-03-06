//
//  StretchyHeaderTableViewController.swift
//  Music
//
//  Created by Andre Navarro on 3/4/20.
//  Copyright © 2020 DML. All rights reserved.
//

import UIKit

/// View controller container with an imageview, title and scrollView as content.
/// inspired by spotify (BLASPHEMY!)

class StretychHeaderTitleView: UIView {
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
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: 0, y: frame.size.height - 100, width: frame.size.width, height: 100)
    }
}

class StretchyHeaderScrollViewController: UIViewController {
    var headerHeight: CGFloat
    
    lazy var headerImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = .black
        return view
    }()

    var contentViewController: UIViewController
    var childScrollView: UIScrollView
    var headerView: UIView?
    
    private var didSetInitialFrames = false
    private var contentOffsetObservation: NSKeyValueObservation?
    
    deinit {
        contentOffsetObservation?.invalidate()
    }
    
    init(headerView: UIView? = nil, headerHeight: CGFloat = 400) {
        // dummies
        self.contentViewController = UIViewController()
        self.childScrollView = UIScrollView()
        self.childScrollView.contentSize = UIScreen.main.bounds.size

        self.headerView = headerView
        self.headerHeight = headerHeight

        super.init(nibName: nil, bundle: nil)
        
        setContentViewController(self.contentViewController, scrollView: self.childScrollView)
    }
    
    func setContentViewController(_ contentViewController: UIViewController, scrollView: UIScrollView? = nil) {
        cleanUp()
        
        self.contentViewController = contentViewController
        if let scrollViewToUse = scrollView {
            self.childScrollView = scrollViewToUse
            view.addSubview(scrollViewToUse)
        }
        else if let scrollViewToUse = contentViewController.view as? UIScrollView {
            self.childScrollView = scrollViewToUse
            view.addSubview(contentViewController.view)
        }
        else {
            fatalError("this container needs a scrollView to function")
        }
        
        if let headerView = headerView {
            childScrollView.addSubview(headerView)
        }
        childScrollView.contentInset = UIEdgeInsets(top: headerHeight, left: 0, bottom: 0, right: 0)
        
        // add content view
        addChild(contentViewController)
        contentViewController.didMove(toParent: self)
        
        contentOffsetObservation = childScrollView.observe(\.contentOffset) { [weak self] scrollView, contentOffset in
            self?.updatedContentOffset()
        }
        
        setFrames()
    }
    
    func cleanUp() {
        contentOffsetObservation?.invalidate()
        
        contentViewController.remove()
        childScrollView.contentInset = .zero
        if let headerView = headerView,
            childScrollView.subviews.contains(headerView) {
            headerView.removeFromSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        view.addSubview(headerImageView)
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
        childScrollView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        headerView?.frame = CGRect(x: 0, y: -headerHeight, width: self.view.bounds.width, height: headerHeight)
        headerImageView.frame = CGRect(x: 0,
                                       y: self.view.safeAreaInsets.top,
                                       width: self.view.bounds.width,
                                       height: self.view.bounds.width)
        
        contentViewController.view.frame = view.bounds
    }
    
    
    private func updatedContentOffset() {
        let tableViewYOffset = -childScrollView.contentOffset.y - self.view.safeAreaInsets.top - headerHeight
                
        if tableViewYOffset > 0 {
            updateHeaderImageHeight(tableViewYOffset)
        }
        else {
            updateHeaderImageChill(tableViewYOffset)
        }
    }

    private func updateHeaderImageHeight(_ tableViewYOffset: CGFloat) {
        let originalHeight = self.view.bounds.width
        let height = originalHeight + tableViewYOffset - childScrollView.contentInset.top + headerHeight
        headerImageView.frame = CGRect(x: 0, y: self.view.safeAreaInsets.top, width: self.view.bounds.width, height: height)
    }
    
    private func updateHeaderImageChill(_ tableViewYOffset: CGFloat) {
        if headerHeight > 0 {
            let percentageOfChill = -(-1 - (tableViewYOffset / headerHeight))
            if 0...1 ~= percentageOfChill {
                headerImageView.transform = CGAffineTransform(scaleX: percentageOfChill, y: percentageOfChill)
                headerImageView.alpha = percentageOfChill
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
