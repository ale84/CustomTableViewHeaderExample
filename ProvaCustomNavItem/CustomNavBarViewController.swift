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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.customNavigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.customNavigationBar.shadowImage = UIImage()
        self.customNavigationBar.translucent = true
        let item = UINavigationItem(title: "")
        customNavigationBar.pushNavigationItem(item, animated: true)
    }
    
    @IBAction func handlePan(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(self.view)
//        headerView.center = CGPoint(x:headerView.center.x,
//                              y:headerView.center.y + translation.y)
        sender.setTranslation(CGPointZero, inView: self.view)
        
        //if translation.y <= 0 {
        view.layoutIfNeeded()
        
        let newConstant = verticalSpaceConstraint.constant + translation.y
        
        if newConstant < 0 || newConstant > 136 {
            
        }
        else {
            verticalSpaceConstraint.constant = newConstant
        }
        //}
        
        //headerView.alpha = headerView.alpha - 0.01
        if sender.state == .Ended {
            headerView.alpha = 1.0
            let fadeTextAnimation = CATransition()
            fadeTextAnimation.duration = 0.5
            fadeTextAnimation.type = kCATransitionFade
            
            customNavigationBar.layer.addAnimation(fadeTextAnimation, forKey: "fadeText")
            customNavigationBar.topItem?.title = arc4random() % 2 == 0 ? "test 123" : "asdasd"
        }
    }
}

extension CustomNavBarViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}