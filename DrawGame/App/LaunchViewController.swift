//
//  LaunchViewController.swift
//  DrawGame
//
//  Created by Carlos Villanueva Ousset on 10/29/17.
//  Copyright © 2017 Carlos Villanueva Ousset. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetup()
    }
    
    fileprivate func initialSetup() {
        view.backgroundColor = Theme.Colors.background
    }
}
