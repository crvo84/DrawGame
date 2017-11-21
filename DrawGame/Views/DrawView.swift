//
//  DrawView.swift
//  DrawGame

import UIKit
import SnapKit

protocol DrawViewDelegate: class {

}

class DrawView: UIView {
    
    private struct Default {
        struct Geometry {
            static let brushWidth: CGFloat = 5.0
        }
        struct Color {
            static let brush = UIColor.green
            static let canvas = UIColor.white
        }
    }
    
    weak var delegate: DrawViewDelegate?
    
    private var mainImageView = UIImageView()
    private var tempImageView = UIImageView()
    
    private var lastPoint = CGPoint.zero
    private var swiped = false
    
    var canvasColor: UIColor = Default.Color.canvas
    var brushColor: UIColor = Default.Color.brush
    var brushWidth: CGFloat = Default.Geometry.brushWidth
    
    var isDrawingEnabled = true
    
    /* Initialization */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initialSetup()
    }
    
    private func initialSetup() {
        addSubview(mainImageView)
        mainImageView.contentMode = .scaleToFill
        mainImageView.layer.magnificationFilter = kCAFilterNearest
        mainImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(tempImageView)
        tempImageView.contentMode = .scaleToFill
        tempImageView.layer.magnificationFilter = kCAFilterNearest
        tempImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backgroundColor = Default.Color.canvas
    }
    
    /* API */
    
    func reset() {
        mainImageView.image = nil
        tempImageView.image = nil
        backgroundColor = Default.Color.canvas
    }
    
    /* Drawing */
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDrawingEnabled else { return }
        
        swiped = false
        if let touch = touches.first {
            lastPoint = touch.location(in: self)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDrawingEnabled else { return }
        
        swiped = true
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            drawLine(from: lastPoint, to: currentPoint)
            
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDrawingEnabled else { return }
        
        if !swiped {
            // draw single point
            drawLine(from: lastPoint, to: lastPoint)
        }
        
        // Merge tempImageView into mainImageView
        UIGraphicsBeginImageContext(mainImageView.frame.size)
        mainImageView.image?.draw(in: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        tempImageView.image?.draw(in: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        tempImageView.image = nil
    }
    
    private func drawLine(from: CGPoint, to: CGPoint) {
        // 1
        UIGraphicsBeginImageContext(frame.size)
        let context = UIGraphicsGetCurrentContext()
        tempImageView.image?.draw(in: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        
        // 2
        context?.move(to: from)
        context?.addLine(to: to)
        
        // 3
        context?.setLineCap(.round)
        context?.setLineWidth(brushWidth)
        context?.setStrokeColor(brushColor.cgColor)
        context?.setBlendMode(.normal)
        
        // 4
        context?.strokePath()
        
        // 5
        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
}
