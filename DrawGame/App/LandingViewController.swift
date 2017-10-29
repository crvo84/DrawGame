//
//  LandingViewController.swift
//  DrawGame
//
//  Created by Carlos Villanueva Ousset on 10/28/17.
//  Copyright © 2017 Carlos Villanueva Ousset. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
    
    fileprivate let drawView = DrawView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }

    fileprivate func initialSetup() {
        view.backgroundColor = Theme.Colors.background
        
        view.addSubview(drawView)
        drawView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20.0)
            make.height.equalTo(drawView.snp.width)
            make.centerY.equalToSuperview()
        }
    }
}

