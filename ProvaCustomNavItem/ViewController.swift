//
//  ViewController.swift
//  ProvaCustomNavItem
//
//  Created by Alessio Orlando on 12/07/16.
//  Copyright © 2016 Cinello. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var headerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.titleView = headerView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

