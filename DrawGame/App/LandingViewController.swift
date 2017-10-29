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
    fileprivate let paletteView = PaletteView()

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
        
        view.addSubview(paletteView)
        paletteView.snp.makeConstraints { make in
            make.top.equalTo(drawView.snp.bottom).offset(8.0)
            make.height.equalTo(60)
            make.left.right.equalToSuperview()
        }
        paletteView.delegate = self
        paletteView.dataSource = self
        paletteView.reloadData()
    }
}

extension LandingViewController: PaletteViewDataSource {
    func colors(forPaletteView: PaletteView) -> [UIColor] {
        return [.blue, .yellow, .green, .red, .green, .lightGray, .gray, .darkGray, .black]
    }
}

extension LandingViewController: PaletteViewDelegate {
    func didSelectColor(_ color: UIColor, paletteView: PaletteView) {
        
    }
}

