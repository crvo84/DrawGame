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
        
        struct ActionButton {
            static let topOffset: CGFloat = 20.0
            static let bottomOffset: CGFloat = 20.0
            static let horizontalInset: CGFloat = 20.0
            static let cornerRadius: CGFloat = 10.0
            static let borderWidth: CGFloat = 0.0
            static let fontSize: CGFloat = 20.0
        }
        
        struct PickerView {
            static let doneButtonHeight: CGFloat = 70.0
            static let rowHeight: CGFloat = 50.0
            static let fontSize: CGFloat = 20.0
        }
    }
    
    fileprivate struct Colors {
        static let wordLabel: UIColor = Theme.Colors.primaryText
        static let drawViewBorder: UIColor = Theme.Colors.main
        static let actionButtonDrawBg = UIColor(red: 0.0, green: 1.0, blue: 0.5, alpha: 1.0)
        static let actionButtonDrawText = UIColor(red: 0.0, green: 0.1, blue: 0.05, alpha: 1.0)
        static let actionButtonGuessBg = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
        static let actionButtonGuessText = UIColor(red: 0.0, green: 0.05, blue: 0.1, alpha: 1.0)
        static let actionButtonWaitBg = UIColor.lightGray
        static let actionButtonWaitText = UIColor.darkGray
        static let pickerViewRowText = UIColor.darkGray
    }
    
    fileprivate let wordLabel = UILabel()
    fileprivate let drawView = DrawView()
    fileprivate let guessImageView = UIImageView()
    fileprivate let paletteView = PaletteView()
    fileprivate let brushesView = BrushesView()
    fileprivate let actionButton = UIButton()
    fileprivate let notVisibleTextField = UITextField()
    fileprivate let wordPickerView = UIPickerView()
    
    fileprivate let game: Game
    fileprivate var gameState: GameState
    
    fileprivate var optionWords: [String]?
    fileprivate var guessedWord: String?
    
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
        
        /* Action Button */
        view.addSubview(actionButton)
        actionButton.layer.cornerRadius = Geometry.ActionButton.cornerRadius
        actionButton.layer.borderWidth = Geometry.ActionButton.borderWidth
        actionButton.layer.masksToBounds = true
        actionButton.snp.makeConstraints { make in
            make.top.equalTo(brushesView.snp.bottom).offset(Geometry.ActionButton.topOffset)
            make.left.right.equalToSuperview().inset(Geometry.ActionButton.horizontalInset)
            make.bottom.equalToSuperview().offset(-Geometry.ActionButton.bottomOffset)
        }
        actionButton.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
        
        /* Not visible text field */
        view.layoutIfNeeded()
        notVisibleTextField.addDoneButtonWithText("Elegir", target: self, action: #selector(selectWordButtonPressed),
                                                  width: view.frame.width, height: Geometry.PickerView.doneButtonHeight)
        // configure picker view
        view.addSubview(notVisibleTextField)
        notVisibleTextField.backgroundColor = Theme.Colors.background
        notVisibleTextField.snp.makeConstraints { make in
            make.width.height.equalTo(1)
            make.bottom.left.equalToSuperview()
        }
        notVisibleTextField.inputView = wordPickerView
        wordPickerView.dataSource = self
        wordPickerView.delegate = self
        
        actionButton.setContentHuggingPriority(.defaultLow, for: .vertical)
        wordLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
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
            
            actionButton.backgroundColor = Colors.actionButtonGuessBg
            actionButton.layer.borderColor = Colors.actionButtonGuessText.cgColor
            let actionButtonTitle = AttributedStringMake { (attrs, ctx) in
                attrs.font = UIFont.systemFont(ofSize: Geometry.ActionButton.fontSize)
                attrs.foregroundColor = Colors.actionButtonGuessText
                attrs.alignment = .center
                ctx.append("Adivinar")
            }
            actionButton.setAttributedTitle(actionButtonTitle, for: .normal)
            actionButton.isEnabled = true
            
        case .draw:
            title = "Dibujando"
            
            actionButton.backgroundColor = Colors.actionButtonDrawBg
            actionButton.layer.borderColor = Colors.actionButtonDrawText.cgColor
            let actionButtonTitle = AttributedStringMake { (attrs, ctx) in
                attrs.font = UIFont.systemFont(ofSize: Geometry.ActionButton.fontSize)
                attrs.foregroundColor = Colors.actionButtonDrawText
                attrs.alignment = .center
                ctx.append("Enviar")
            }
            actionButton.setAttributedTitle(actionButtonTitle, for: .normal)
            actionButton.isEnabled = true
            
        case .wait:
            title = "Esperando"
            
            actionButton.backgroundColor = Colors.actionButtonWaitBg
            actionButton.layer.borderColor = Colors.actionButtonWaitText.cgColor
            let actionButtonTitle = AttributedStringMake { (attrs, ctx) in
                attrs.font = UIFont.systemFont(ofSize: Geometry.ActionButton.fontSize)
                attrs.foregroundColor = Colors.actionButtonWaitText
                attrs.alignment = .center
                ctx.append("Esperando...")
            }
            actionButton.setAttributedTitle(actionButtonTitle, for: .normal)
            actionButton.isEnabled = false
        }
    }
    
    fileprivate func resetUI() {
        drawView.reset()
        wordLabel.text = nil
    }
    
    fileprivate func setupOptionWords() {
        let correctWord = game.drawing.word
        if let optionWords = self.optionWords, optionWords.contains(correctWord) {
            return
        }
        
        self.optionWords = WordManager.getAnswerOptions(totalCount: 10,
                                                        correctAnswer: correctWord)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        notVisibleTextField.resignFirstResponder()
    }
    
    @objc fileprivate func actionButtonPressed() {
        switch gameState {
        case .guess:
            guard !notVisibleTextField.isFirstResponder else { return }
            setupOptionWords()
            notVisibleTextField.becomeFirstResponder()
            
        case .draw:
        // TODO: api request for sending drawing
            return
            
        case.wait:
            return
        }
    }
    
    @objc fileprivate func selectWordButtonPressed() {
        notVisibleTextField.resignFirstResponder()
        let selectedRow = wordPickerView.selectedRow(inComponent: 0)
        let selectedWord = optionWords?[selectedRow]
        self.guessedWord = selectedWord
        
        // continue to draw
        gameState = .draw
        updateUI()
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

extension GameViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return optionWords?.count ?? 0
    }
}

extension GameViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return Geometry.PickerView.rowHeight
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.width
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return AttributedStringMake { (attrs, ctx) in
            attrs.foregroundColor = Colors.pickerViewRowText
            attrs.font = UIFont.systemFont(ofSize: Geometry.PickerView.fontSize)
            attrs.alignment = .center
            ctx.append(optionWords?[row])
        }
    }
}












