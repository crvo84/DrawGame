//
//  PaletteView.swift
//  DrawGame

import UIKit

protocol PaletteViewDataSource: class {
    func colors(forPaletteView: PaletteView) -> [UIColor]
}

protocol PaletteViewDelegate: class {
    func didSelectColor(_ color: UIColor, paletteView: PaletteView)
}

class PaletteView: UIView {
    
    fileprivate struct Geometry {
        static let colorSizeRatio: CGFloat = 1.0
        static let colorSpacing: CGFloat = 16.0
        static let horizontalContentInset: CGFloat = 40.0
        static let verticalContentInset: CGFloat = 8.0
    }
    
    fileprivate struct Colors {
        static let backgroundColor: UIColor = .white
    }
    
    fileprivate struct ReuseId {
        static let colorCell = "ColorCollectionViewCell"
    }
    
    weak var dataSource: PaletteViewDataSource?
    weak var delegate: PaletteViewDelegate?
    
    fileprivate let collectionView: UICollectionView!
    
    fileprivate var colors: [UIColor] = []
    
    // MARK: - Initialization
    
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
//        collectionView.isPagingEnabled = true
        collectionView.register(ColorCollectionViewCell.self,
                                forCellWithReuseIdentifier: ReuseId.colorCell)
    }
    
    // MARK: - Update
    
    func reloadData() {
        let newColors = dataSource?.colors(forPaletteView: self) ?? []
        guard self.colors != newColors else { return } // nothing to update
        
        self.colors = newColors
        collectionView.reloadData()
    }
}

 extension PaletteView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseId.colorCell,
                                                      for: indexPath)
        
        if let colorCell = cell as? ColorCollectionViewCell {
            let color = colors[indexPath.row]
            colorCell.color = color
            colorCell.colorWithBorder = Colors.backgroundColor
            colorCell.delegate = self
        }
        
        return cell
    }
}

extension PaletteView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        return
    }
}

extension PaletteView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let height = collectionView.bounds.height - Geometry.verticalContentInset * 2
        let width = height * Geometry.colorSizeRatio

        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Geometry.verticalContentInset,
                            left: Geometry.horizontalContentInset,
                            bottom: Geometry.verticalContentInset,
                            right: Geometry.horizontalContentInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Geometry.colorSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Geometry.colorSpacing
    }
}

extension PaletteView: ColorCollectionViewCellDelegate {
    func didPressButton(colorCollectionViewCell: ColorCollectionViewCell) {
        guard let color = colorCollectionViewCell.color else { return }
        delegate?.didSelectColor(color, paletteView: self)
    }
}










