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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.customNavigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.customNavigationBar.shadowImage = UIImage()
        self.customNavigationBar.translucent = true
        let item = UINavigationItem(title: "")
        customNavigationBar.pushNavigationItem(item, animated: true)
        
        headerView.layoutIfNeeded()
        headerViewOriginalHeight = headerView.frame.size.height
    }
    
    @IBAction func handlePan(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(self.view)
        sender.setTranslation(CGPointZero, inView: self.view)
        
//        if sender.state == .Ended {
//            let fadeTextAnimation = CATransition()
//            fadeTextAnimation.duration = 0.5
//            fadeTextAnimation.type = kCATransitionFade
//            
//            customNavigationBar.layer.addAnimation(fadeTextAnimation, forKey: "fadeText")
//            customNavigationBar.topItem?.title = arc4random() % 2 == 0 ? "test 123" : "asdasd"
//        }
        
        let newConstant = verticalSpaceConstraint.constant + translation.y

        switch newConstant {
        case 0..<headerViewOriginalHeight/2:
            headerView.alpha = 0
        case headerViewOriginalHeight/2...headerViewOriginalHeight:
            let alphaChange = translation.y/(headerViewOriginalHeight/2)
            var newAlpha = headerView.alpha + alphaChange
            if newAlpha <= 0 {
                newAlpha = 0
            }
            if newAlpha > 1 {
                newAlpha = 1
            }
            headerView.alpha = newAlpha
        case _ where newConstant > headerViewOriginalHeight:
            headerView.alpha = 1
        default:
            break
        }

        if newConstant < 0 {
            verticalSpaceConstraint.constant = 0
        }
        else if newConstant > headerViewOriginalHeight {
            verticalSpaceConstraint.constant = headerViewOriginalHeight
        }
        else {
            verticalSpaceConstraint.constant = newConstant
        }
        view.layoutIfNeeded()
    }
}

extension CustomNavBarViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}