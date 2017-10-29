//
//  BrushesView.swift
//  DrawGame
//
//  Created by Carlos Villanueva Ousset on 10/29/17.
//  Copyright © 2017 Carlos Villanueva Ousset. All rights reserved.
//

import UIKit

protocol BrushesViewDataSource: class {
    func widths(forBrushesView: BrushesView) -> [CGFloat]
}

protocol BrushesViewDelegate: class {
    func didSelectWidth(_ width: CGFloat, brushesView: BrushesView)
}

class BrushesView: UIView {

    fileprivate struct Geometry {
        static let cellSizeRatio: CGFloat = 1.0
        static let cellSpacing: CGFloat = 16.0
        static let horizontalContentInset: CGFloat = 20.0
        static let verticalContentInset: CGFloat = 8.0
    }
    
    fileprivate struct Colors {
        static let backgroundColor: UIColor = .white
        static let defaultColor: UIColor = .black
    }
    
    fileprivate struct ReuseId {
        static let brushCell = "BrushCollectionViewCell"
    }
    
    weak var dataSource: BrushesViewDataSource?
    weak var delegate: BrushesViewDelegate?
    
    fileprivate let collectionView: UICollectionView!
    
    fileprivate var widths: [CGFloat] = []
    
    var color: UIColor? { didSet { updateColor() } }
    
    // MARK: - Initialize
    
    required override init(frame: CGRect) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect.zero,
                                          collectionViewLayout: flowLayout)
        super.init(frame: frame)
        
        initialSetup()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    fileprivate func initialSetup() {
        addSubview(collectionView)
        collectionView.backgroundColor = Colors.backgroundColor
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.register(ColorCollectionViewCell.self,
                                forCellWithReuseIdentifier: ReuseId.brushCell)
    }
    
    // MARK: - Update
    
    func reloadData() {
        let newWidths = dataSource?.widths(forBrushesView: self) ?? []
        guard self.widths != newWidths else { return } // nothing to update
        
        self.widths = newWidths
        collectionView.reloadData()
    }
    
    fileprivate func updateColor() {
        _ = collectionView.visibleCells.map {
            if let brushCell = $0 as? BrushCollectionViewCell {
                brushCell.color = color
                brushCell.colorWithBorder = Colors.backgroundColor
            }
        }
    }
}

extension BrushesView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return widths.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseId.brushCell,
                                                      for: indexPath)
        
        if let brushCell = cell as? BrushCollectionViewCell {
            let width = widths[indexPath.row]
            brushCell.width = width
            brushCell.color = color ?? Colors.defaultColor
            brushCell.delegate = self
        }
        
        return cell
    }
}

extension BrushesView: UICollectionViewDelegate {
    
}

extension BrushesView: BrushCollectionViewCellDelegate {
    func didPressButton(brushCollectionViewCell: BrushCollectionViewCell) {
        guard let width = brushCollectionViewCell.width else { return }
        delegate?.didSelectWidth(width, brushesView: self)
    }
}















