//
//  BrushCollectionViewCell.swift
//  DrawGame

import UIKit

protocol BrushCollectionViewCellDelegate: class {
    func didPressButton(brushCollectionViewCell: BrushCollectionViewCell)
}

class BrushCollectionViewCell: UICollectionViewCell {
    
    fileprivate struct Default {
        static let color: UIColor = .black
        static let width: CGFloat = 5.0
        static let borderColor: UIColor = .lightGray
        static let borderWidth: CGFloat = 0.5
    }
    
    weak var delegate: BrushCollectionViewCellDelegate?
    
    fileprivate var brushView = UIView()
    fileprivate var button = UIButton()
    
    var width: CGFloat? { didSet { updateWidth() } }
    var color: UIColor? { didSet { updateColor() } }
    var borderColor: UIColor? { didSet { updateColor() } }
    var borderWidth: CGFloat? { didSet { updateColor() } }
    var colorWithBorder: UIColor? { didSet { updateColor() } }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    fileprivate func initialSetup() {
        isOpaque = false
        contentView.isOpaque = false
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        // brush view
        contentView.addSubview(brushView)
        brushView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(Default.width)
            make.width.equalTo(brushView.snp.height)
        }
        
        // button
        contentView.addSubview(button)
        button.backgroundColor = .clear
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        button.addTarget(self, action: #selector(didPressButton), for: .touchUpInside)
        
        updateColor()
    }
    
    // MARK: - Update
    
    fileprivate func updateWidth() {
        let width = self.width ?? Default.width
        brushView.snp.updateConstraints { make in
            make.height.equalTo(width)
        }
        contentView.layoutIfNeeded()
        brushView.layer.cornerRadius = brushView.bounds.height / 2
        brushView.layer.masksToBounds = true
    }
    
    fileprivate func updateColor() {
        let color = self.color ?? Default.color
        brushView.backgroundColor = color
        
        if let colorWithBorder = colorWithBorder, colorWithBorder == color {
            let borderWidth = self.borderWidth ?? Default.borderWidth
            let borderColor = self.borderColor ?? Default.borderColor
            brushView.layer.borderWidth = borderWidth
            brushView.layer.borderColor = borderColor.cgColor
        } else {
            brushView.layer.borderWidth = 0.0
        }
    }
    
    @objc fileprivate func didPressButton() {
        delegate?.didPressButton(brushCollectionViewCell: self)
    }
}
















