//
//  GameViewController.swift
//  DrawGame
//
//  Created by Carlos Villanueva Ousset on 10/28/17.
//  Copyright © 2017 Carlos Villanueva Ousset. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    fileprivate enum GameState {
        case guess, draw, wait
    }
    
    fileprivate struct Geometry {
        struct WordLabel {
            static let topOffset: CGFloat = 24.0
            static let horizontalInset: CGFloat = 20.0
            static let fontSize: CGFloat = 24.0
        }
        
        struct DrawView {
            static let topOffset: CGFloat = 20.0
            static let width: Int = 256
            static let height: Int = 256
            static let borderWidth: CGFloat = 2.0
        }
        
        struct PaletteView {
            static let topOffset: CGFloat = 20.0
            static let height: CGFloat = 60.0
        }
        
        struct BrushView {
            static let topOffset: CGFloat = 8.0
            static let height: CGFloat = 60.0
        }
    }
    
    fileprivate struct Colors {
        static let wordLabel: UIColor = Theme.Colors.primaryText
        static let drawViewBorder: UIColor = Theme.Colors.main
    }
    
    fileprivate let wordLabel = UILabel()
    fileprivate let drawView = DrawView()
    fileprivate let guessImageView = UIImageView()
    fileprivate let paletteView = PaletteView()
    fileprivate let brushesView = BrushesView()
    
    fileprivate let game: Game
    fileprivate var gameState: GameState
    
    init(game: Game) {
        self.game = game
        let iAmPlayerA = Api.udid == game.playerAId
        
        if let _ = game.playerBId {
            if game.isPlayerATurn {
                self.gameState = iAmPlayerA ? .guess : .wait
            } else {
                self.gameState = iAmPlayerA ? .wait : .guess
            }
        } else {
            // No playerBId, so I must be player A then
            self.gameState = game.isPlayerATurn ? .draw : .wait
        }

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
        updateUI()
    }

    fileprivate func initialSetup() {
        view.backgroundColor = Theme.Colors.background

        /* Word Label */
        view.addSubview(wordLabel)
        wordLabel.numberOfLines = 1
        wordLabel.adjustsFontSizeToFitWidth = true
        wordLabel.minimumScaleFactor = 0.6
        wordLabel.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(Geometry.WordLabel.topOffset)
            make.left.right.equalToSuperview().inset(Geometry.WordLabel.horizontalInset)
        }
        
        /* Draw View */
        view.addSubview(drawView)
        drawView.snp.makeConstraints { make in
            make.top.equalTo(wordLabel.snp.bottom).offset(Geometry.DrawView.topOffset)
            make.width.equalTo(Geometry.DrawView.width)
            make.height.equalTo(Geometry.DrawView.height)
            make.centerX.equalToSuperview()
        }
        drawView.layer.masksToBounds = false
        drawView.layer.borderColor = Colors.drawViewBorder.cgColor
        drawView.layer.borderWidth = Geometry.DrawView.borderWidth
        
        /* Guess Image View */
        view.addSubview(guessImageView)
        guessImageView.snp.makeConstraints { make in
            make.edges.equalTo(drawView)
        }
        
        /* Palette View */
        view.addSubview(paletteView)
        paletteView.snp.makeConstraints { make in
            make.top.equalTo(drawView.snp.bottom).offset(Geometry.PaletteView.topOffset)
            make.left.right.equalToSuperview()
            make.height.equalTo(Geometry.PaletteView.height)
        }
        paletteView.delegate = self
        paletteView.dataSource = self
        paletteView.reloadData()
        
        /* Brushes View */
        view.addSubview(brushesView)
        brushesView.snp.makeConstraints { make in
            make.top.equalTo(paletteView.snp.bottom).offset(Geometry.BrushView.topOffset)
            make.left.right.equalToSuperview()
            make.height.equalTo(Geometry.BrushView.height)
        }
        brushesView.delegate = self
        brushesView.dataSource = self
        brushesView.reloadData()
    }
    
    fileprivate func updateUI() {
        resetUI()
        
        wordLabel.attributedText = AttributedStringMake { (attrs, ctx) in
            attrs.font = UIFont.systemFont(ofSize: Geometry.WordLabel.fontSize)
            attrs.foregroundColor = Colors.wordLabel
            attrs.alignment = .center
            switch gameState {
            case .guess:
                ctx.append("?")
            case .draw, .wait:
                ctx.append(game.drawing.word)
            }
        }
        
        switch gameState {
        case .guess, .wait:
            drawView.isHidden = true
            paletteView.isHidden = true
            brushesView.isHidden = true
            guessImageView.isHidden = false
            
            // auto draw on canvas
            guessImageView.image = game.drawing.image
            guessImageView.contentMode = .scaleAspectFit
            
        case .draw:
            drawView.isHidden = false
            paletteView.isHidden = false
            brushesView.isHidden = false
            guessImageView.isHidden = true
        }
        
        switch gameState {
        case .guess:
            title = "Adivinando"
        case .draw:
            title = "Dibujando"
        case .wait:
            title = "Esperando"
        }
    }
    
    fileprivate func resetUI() {
        drawView.reset()
        wordLabel.text = nil
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
















