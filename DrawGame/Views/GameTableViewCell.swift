import UIKit

class GameTableViewCell: UITableViewCell {
    
    fileprivate struct Geometry {
        static let horizontalContentInset: CGFloat = 20.0
        static let verticalContentInset: CGFloat = 8.0
        static let otherScoreLabelTopOffset: CGFloat = 8.0
        static let fontSize: CGFloat = 16.0
    }
    
    fileprivate struct Colors {
        static let yourScoreLabel = UIColor(red: 0.0, green: 0.0, blue: 0.20, alpha: 1.0)
        static let otherScoreLabel = UIColor.darkGray
        static let myTurnBg = UIColor(red: 0.85, green: 1.0, blue: 0.85, alpha: 1.0)
        static let notMyTurnBg = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
    }
    
    fileprivate let yourScoreLabel: UILabel()
    fileprivate let otherScoreLabel: UILabel()
    
    var game: Game? { didSet { updateUI() } }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initialSetup()
    }
    
    fileprivate func initialSetup() {
        // your score label
        contentView.addSubview(yourScoreLabel)
        yourScoreLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Geometry.horizontalContentInset)
            make.top.equalToSuperview().offset(Geometry.verticalContentInset)
            make.right.equalToSuperview().offset(-Geometry.horizontalContentInset)
        }
        
        // other score label
        contentView.addSubview(otherScoreLabel)
        otherScoreLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Geometry.horizontalContentInset)
            make.top.equalTo(yourScoreLabel).offset(Geometry.otherScoreLabelTopOffset)
            make.right.equalToSuperview().offset(-Geometry.horizontalContentInset)
            make.bottom.equalToSuperview().offset(-Geometry.verticalContentInset)
        }
    }
    
    fileprivate func updateUI() {
        resetUI()
        
        guard let game = game else { return }
        
        contentView.backgroundColor = game.isMyTurn ? Colors.myTurnBg : Colors.notMyTurnBg
        
        // your score
        yourScoreLabel.attributedText = AttributedStringMake { (attrs, ctx) in
            attrs.font = UIFont.systemFont(ofSize: Geometry.fontSize)
            attrs.foregroundColor = Colors.yourScoreLabel
            attrs.alignment = .left
            ctx.append("Your score: \(game.myScore)")
        }
        
        // other score
        otherScoreLabel.attributedText = AttributedStringMake { (attrs, ctx) in
            attrs.font = UIFont.systemFont(ofSize: Geometry.fontSize)
            attrs.foregroundColor = Colors.otherScoreLabel
            attrs.alignment = .left
            ctx.append("Other score: \(game.otherScore)")
        }
    }
    
    fileprivate func resetUI() {
        yourScoreLabel.attributedText = nil
        otherScoreLabel.attributedText = nil
    }
}














