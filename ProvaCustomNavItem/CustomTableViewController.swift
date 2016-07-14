//
//  CustomTableViewController.swift
//  ProvaCustomNavItem
//
//  Created by Alessio Orlando on 12/07/16.
//  Copyright © 2016 Cinello. All rights reserved.
//

import UIKit

class CustomTableViewController: UITableViewController {
    
    override func viewDidLoad() {
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.translucent = true
//        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 250))
            headerView.backgroundColor = UIColor .redColor()
        tableView.addSubview(headerView)
        //tableView.contentInset = UIEdgeInsets(top: tableView.contentInset.top + 250, left: 0, bottom: 0, right: 0)
    }
}
