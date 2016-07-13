//
//  CustomNavBarViewController.swift
//  ProvaCustomNavItem
//
//  Created by Alessio Orlando on 12/07/16.
//  Copyright © 2016 Cinello. All rights reserved.
//

import UIKit

class CustomNavBarViewController: UIViewController {

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
        titleLabel.text = "titolo"
        titleLabel.font = UIFont.boldSystemFontOfSize(17)
        titleLabel.sizeToFit()
        item.titleView = titleLabel
        
        customNavigationBar.pushNavigationItem(item, animated: true)
        
        headerView.layoutIfNeeded()
        headerViewOriginalHeight = headerView.frame.size.height
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        titleLabel.alpha = 0
    }
    
    @IBAction func handlePan(sender: UIPanGestureRecognizer) {
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