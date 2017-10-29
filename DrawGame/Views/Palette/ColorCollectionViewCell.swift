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
        static let borderWidth: CGFloat = 0.5
    }
    
    fileprivate struct Color {
        static let borderColor: UIColor = .lightGray
    }
    
    weak var delegate: ColorCollectionViewCellDelegate?
    
    fileprivate var button = UIButton()
    
    var color: UIColor? { didSet { updateColor() } }
    var colorWithBorder: UIColor? { didSet { updateColor() } }
    
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
        button.addTarget(self, action: #selector(didPressButton), for: .touchUpInside)
        button.layer.cornerRadius = Geometry.cornerRadius
        button.layer.masksToBounds = true
    }
    
    fileprivate func updateColor() {
        button.backgroundColor = color
        if let color = color, let colorWithBorder = colorWithBorder,
            color == colorWithBorder {
            button.layer.borderWidth = Geometry.borderWidth
            button.layer.borderColor = Color.borderColor.cgColor
        } else {
            button.layer.borderWidth = 0.0
        }
    }
    
    @objc fileprivate func didPressButton() {
        delegate?.didPressButton(colorCollectionViewCell: self)
    }
}
