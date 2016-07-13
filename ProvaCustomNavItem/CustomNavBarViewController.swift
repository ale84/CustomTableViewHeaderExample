//
//  CustomNavBarViewController.swift
//  ProvaCustomNavItem
//
//  Created by Alessio Orlando on 12/07/16.
//  Copyright © 2016 Cinello. All rights reserved.
//

import UIKit

class CustomNavBarViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet var verticalSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var customNavigationBar: UINavigationBar!
    var startLocation: CGPoint? = nil
    var headerViewOriginalHeight: CGFloat = 0
    var titleLabel: UILabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.customNavigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.customNavigationBar.shadowImage = UIImage()
        self.customNavigationBar.translucent = true
        
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
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        titleLabel.alpha = 0
    }
    
    @IBAction func handlePan(sender: UIPanGestureRecognizer) {
//        let tableViewOffsetY = tableView.contentOffset.y + tableView.contentInset.top
//        guard tableViewOffsetY >= 0 && tableViewOffsetY <= headerViewOriginalHeight else {
//            return
//        }
        
        let translation = sender.translationInView(self.view)
        sender.setTranslation(CGPointZero, inView: self.view)
        
        var newConstant = verticalSpaceConstraint.constant + translation.y
        let alphaChange = translation.y/(headerViewOriginalHeight/2)

        switch newConstant {
        case 1..<headerViewOriginalHeight/2:
            headerView.alpha = 0
            titleLabel.alpha = titleLabel.alpha - alphaChange
        case headerViewOriginalHeight/2...headerViewOriginalHeight:
            titleLabel.alpha = 0
            headerView.alpha = headerView.alpha + alphaChange
        case _ where newConstant > headerViewOriginalHeight:
            newConstant = headerViewOriginalHeight
            headerView.alpha = 1
        case _ where newConstant <= 0:
            newConstant = 1
            titleLabel.alpha = 1
        default:
            break
        }
        verticalSpaceConstraint.constant = newConstant
    }
}

extension CustomNavBarViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension CustomNavBarViewController: UITableViewDelegate, UITableViewDataSource {
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
}