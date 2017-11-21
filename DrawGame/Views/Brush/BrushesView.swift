//
//  BrushesView.swift
//  DrawGame

import UIKit

protocol BrushesViewDataSource: class {
    func widths(forBrushesView: BrushesView) -> [CGFloat]
    func color(forBrushesView: BrushesView) -> UIColor
}

protocol BrushesViewDelegate: class {
    func didSelectWidth(_ width: CGFloat, brushesView: BrushesView)
}

class BrushesView: UIView {

    fileprivate struct Geometry {
        static let cellSizeRatio: CGFloat = 1.0
        static let cellSpacing: CGFloat = 16.0
        static let horizontalContentInset: CGFloat = 40.0
        static let verticalContentInset: CGFloat = 8.0
    }
    
    fileprivate struct Colors {
        static let backgroundColor: UIColor = .clear
        static let defaultColor: UIColor = .black
    }
    
    fileprivate struct ReuseId {
        static let brushCell = "BrushCollectionViewCell"
    }
    
    weak var dataSource: BrushesViewDataSource?
    weak var delegate: BrushesViewDelegate?
    
    fileprivate let collectionView: UICollectionView!
    
    fileprivate var widths: [CGFloat] = []
    fileprivate var color: UIColor = Colors.defaultColor

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
        isOpaque = false
        backgroundColor = Colors.backgroundColor
        addSubview(collectionView)
        collectionView.isOpaque = false
        collectionView.backgroundColor = Colors.backgroundColor
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.isPagingEnabled = true
        collectionView.register(BrushCollectionViewCell.self,
                                forCellWithReuseIdentifier: ReuseId.brushCell)
    }
    
    // MARK: - Update
    
    func reloadData() {
        let newWidths = dataSource?.widths(forBrushesView: self) ?? []
        let newColor = dataSource?.color(forBrushesView: self) ?? Colors.defaultColor
        guard self.widths != newWidths || self.color != newColor
            else { return } // nothing to update
        
        self.widths = newWidths
        self.color = newColor
        collectionView.reloadData()
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
            brushCell.color = self.color
            brushCell.colorWithBorder = Colors.backgroundColor
            brushCell.delegate = self
        }
        
        return cell
    }
}

extension BrushesView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        return
    }
}

extension BrushesView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = collectionView.bounds.height - Geometry.verticalContentInset * 2
        let width = height * Geometry.cellSizeRatio
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Geometry.verticalContentInset,
                            left: Geometry.horizontalContentInset,
                            bottom: Geometry.verticalContentInset,
                            right: Geometry.horizontalContentInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Geometry.cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Geometry.cellSpacing
    }
}

extension BrushesView: BrushCollectionViewCellDelegate {
    func didPressButton(brushCollectionViewCell: BrushCollectionViewCell) {
        guard let width = brushCollectionViewCell.width else { return }
        delegate?.didSelectWidth(width, brushesView: self)
    }
}















