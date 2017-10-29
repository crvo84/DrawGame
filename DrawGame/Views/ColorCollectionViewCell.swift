//
//  ColorCollectionViewCell.swift
//  DrawGame
//
//  Created by Carlos Villanueva Ousset on 10/29/17.
//  Copyright © 2017 Carlos Villanueva Ousset. All rights reserved.
//

import UIKit

protocol ColorCollectionViewCellDelegate: class {
    func didPressButton(colorCollectionViewCell: ColorCollectionViewCell)
}

class ColorCollectionViewCell: UICollectionViewCell {
    
    fileprivate struct Geometry {
        static let cornerRadius: CGFloat = 5.0
    }
    
    weak var delegate: ColorCollectionViewCellDelegate?
    
    fileprivate var button = UIButton()
    
    var color: UIColor? { didSet { updateColor() } }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func initialSetup() {
        isOpaque = false
        contentView.isOpaque = false
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        setupButton()
    }
    
    fileprivate func setupButton() {
        contentView.addSubview(button)
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        button.layer.cornerRadius = Geometry.cornerRadius
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(didPressButton), for: .touchUpInside)
    }
    
    fileprivate func updateColor() {
        button.backgroundColor = color
    }
    
    @objc fileprivate func didPressButton() {
        delegate?.didPressButton(colorCollectionViewCell: self)
    }
}
