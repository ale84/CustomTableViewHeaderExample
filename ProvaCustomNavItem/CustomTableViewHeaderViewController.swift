//
//  CustomTableViewHeaderViewController.swift
//  ProvaCustomNavItem
//
//  Created by Alessio Orlando on 12/07/16.
//  Copyright © 2016 Cinello. All rights reserved.
//

import UIKit

class CustomTableViewHeaderViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet var verticalSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var customNavigationBar: UINavigationBar!
    var headerViewOriginalHeight: CGFloat = 0
    var titleLabel: UILabel = UILabel()
    var lastVerticalOffset: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        customNavigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        customNavigationBar.shadowImage = UIImage()
        customNavigationBar.translucent = true
        customNavigationBar.tintColor = UIColor.blackColor()
        
        let item = UINavigationItem(title: "")
        item.backBarButtonItem = UIBarButtonItem(title: "back", style: .Plain, target: nil, action: nil)
        titleLabel.text = "Some Stuff"
        titleLabel.font = UIFont.boldSystemFontOfSize(17)
        titleLabel.sizeToFit()
        item.titleView = titleLabel
        
        customNavigationBar.pushNavigationItem(item, animated: true)
        
        headerView.layoutIfNeeded()
        headerViewOriginalHeight = headerView.frame.size.height
        
        tableView.contentInset = UIEdgeInsets(top: headerViewOriginalHeight, left: 0, bottom: 0, right: 0)
        tableView.scrollIndicatorInsets = tableView.contentInset
        lastVerticalOffset = tableView.contentOffset.y
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        titleLabel.alpha = 0
        headerView.alpha = 1.0
    }
}

extension CustomTableViewHeaderViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let verticalOffset = scrollView.contentOffset.y
        let scrollAmount = verticalOffset - lastVerticalOffset  //get scrolling amount since last update
        lastVerticalOffset = verticalOffset
        let alphaVariation = scrollAmount/(headerViewOriginalHeight/2)
        
        var newConstant = -verticalOffset //newConstant will be the updated value for the verticalSpaceConstraint constant
        
        switch newConstant {
        case _ where newConstant <= 0:
            newConstant = 1
            titleLabel.alpha = 1
        case 1..<headerViewOriginalHeight/2:
            headerView.alpha = 0
            titleLabel.alpha = titleLabel.alpha + alphaVariation
        case headerViewOriginalHeight/2...headerViewOriginalHeight:
            titleLabel.alpha = 0
            headerView.alpha = headerView.alpha - alphaVariation
        case _ where newConstant > headerViewOriginalHeight:
            newConstant = headerViewOriginalHeight
            headerView.alpha = 1
        default:
            break
        }
        verticalSpaceConstraint.constant = newConstant
    }
}