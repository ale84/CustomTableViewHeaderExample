//
//  CustomTableViewHeaderViewController.swift
//  ProvaCustomNavItem
//
//  The MIT License (MIT)
//
//  Copyright (c) 2016 Alessio Orlando
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

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
        customNavigationBar.setBackgroundImage(UIImage(), for: .default)
        customNavigationBar.shadowImage = UIImage()
        customNavigationBar.isTranslucent = true
        customNavigationBar.tintColor = UIColor.black
        
        let item = UINavigationItem(title: "")
        item.backBarButtonItem = UIBarButtonItem(title: "back", style: .plain, target: nil, action: nil)
        titleLabel.text = "Some Stuff"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.sizeToFit()
        item.titleView = titleLabel
        
        customNavigationBar.pushItem(item, animated: true)
        
        headerView.layoutIfNeeded()
        headerViewOriginalHeight = headerView.frame.size.height
        
        tableView.contentInset = UIEdgeInsets(top: headerViewOriginalHeight, left: 0, bottom: 0, right: 0)
        tableView.scrollIndicatorInsets = tableView.contentInset
        lastVerticalOffset = tableView.contentOffset.y
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        titleLabel.alpha = 0
        headerView.alpha = 1.0
    }
}

extension CustomTableViewHeaderViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = "\((indexPath as NSIndexPath).row)"
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
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
