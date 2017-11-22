import UIKit


extension UITextField {
    func addDoneButtonWithText(_ text: String, target: AnyObject, action: Selector, width: CGFloat, height: CGFloat) { // TODO: set as extension for subclass of UITextField
        // Tool bar
        
        let doneToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: width, height: height))
        doneToolBar.barStyle = .default
        
        // Button View
        
        let barButton = UIButton(frame: CGRect(x: 0, y: 0, width: width, height: height))
        barButton.addTarget(target, action: action, for: .touchUpInside)
        barButton.backgroundColor = .clear
        
        let barButtonLabel = UILabel()
        barButton.addSubview(barButtonLabel)
        barButtonLabel.minimumScaleFactor = 0.5
        barButtonLabel.attributedText = AttributedStringMake { (attrs, ctx) in
            attrs.font = UIFont.systemFont(ofSize: 18.0)
            attrs.alignment = .center
            attrs.foregroundColor = Theme.Colors.primaryText
            ctx.append(text)
        }
        barButtonLabel.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(barButton)
            make.left.right.equalTo(barButton).inset(8.0)
        }
        
        // Button Item
        
        let barButtonItem = UIBarButtonItem(customView: barButton)
//        let leftFlexibleItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let rightFlexibleItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        doneToolBar.items = [barButtonItem]
        
        self.inputAccessoryView = doneToolBar
    }
}
