//
//  GameViewController.swift
//  DrawGame
//
//  Created by Carlos Villanueva Ousset on 10/28/17.
//  Copyright © 2017 Carlos Villanueva Ousset. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    fileprivate let drawView = DrawView()
    fileprivate let paletteView = PaletteView()
    fileprivate let brushesView = BrushesView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }

    fileprivate func initialSetup() {
        view.backgroundColor = Theme.Colors.background
        
        // DRAW VIEW
        view.addSubview(drawView)
        drawView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20.0)
            make.height.equalTo(drawView.snp.width)
            make.centerY.equalToSuperview()
        }
        
        // PALETTE VIEW
        view.addSubview(paletteView)
        paletteView.snp.makeConstraints { make in
            make.top.equalTo(drawView.snp.bottom).offset(8.0)
            make.height.equalTo(60)
            make.left.right.equalToSuperview()
        }
        paletteView.delegate = self
        paletteView.dataSource = self
        paletteView.reloadData()
        
        // BRUSHES VIEW
        view.addSubview(brushesView)
        brushesView.snp.makeConstraints { make in
            make.top.equalTo(paletteView.snp.bottom).offset(4.0)
            make.height.equalTo(60)
            make.left.right.equalToSuperview()
        }
        brushesView.delegate = self
        brushesView.dataSource = self
        brushesView.reloadData()
    }
}

extension GameViewController: PaletteViewDataSource {
    func colors(forPaletteView: PaletteView) -> [UIColor] {
        return [.white, .cyan, .blue, .purple, .magenta, .brown, .red, .orange,
                .yellow, .green, .lightGray, .gray, .darkGray, .black]
    }
}

extension GameViewController: PaletteViewDelegate {
    func didSelectColor(_ color: UIColor, paletteView: PaletteView) {
        drawView.brushColor = color
        brushesView.reloadData()
    }
}

extension GameViewController: BrushesViewDataSource {
    func widths(forBrushesView: BrushesView) -> [CGFloat] {
        return [1.0, 2.0, 5.0, 10.0, 15.0, 20.0, 25.0, 30.0, 35.0, 40.0]
    }
    
    func color(forBrushesView: BrushesView) -> UIColor {
        return drawView.brushColor
    }
}

extension GameViewController: BrushesViewDelegate {
    func didSelectWidth(_ width: CGFloat, brushesView: BrushesView) {
        drawView.brushWidth = width
    }
}
















