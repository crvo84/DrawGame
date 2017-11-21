import UIKit

final class AttributedStringMakerAttributes {
    
    // Dictionary
    fileprivate(set) var dictionaryRepresentation = [NSAttributedStringKey: AnyObject]()
    
    // NSFontAttributeName
    var font: UIFont? {
        get {
            return self.dictionaryRepresentation[.font] as? UIFont
        }
        set {
            self.dictionaryRepresentation[.font] = newValue
        }
    }
    
    // NSParagraphStyleAttributeName
    fileprivate(set) var paragraphStyle: NSMutableParagraphStyle {
        get {
            var ps = self.dictionaryRepresentation[.paragraphStyle] as? NSMutableParagraphStyle
            if ps == nil {
                ps = NSMutableParagraphStyle()
                self.dictionaryRepresentation[.paragraphStyle] = ps
            }
            return ps!
        }
        set {
            self.dictionaryRepresentation[.paragraphStyle] = newValue.mutableCopy() as AnyObject?
        }
    }
    var lineSpacing: Double {
        get {
            return Double(self.paragraphStyle.lineSpacing)
        }
        set {
            self.paragraphStyle.lineSpacing = CGFloat(newValue)
        }
    }
    var paragraphSpacing: Double {
        get {
            return Double(self.paragraphStyle.paragraphSpacing)
        }
        set {
            self.paragraphStyle.paragraphSpacing = CGFloat(newValue)
        }
    }
    var alignment: NSTextAlignment {
        get {
            return self.paragraphStyle.alignment
        }
        set {
            self.paragraphStyle.alignment = newValue
        }
    }
    var headIndent: Double {
        get {
            return Double(self.paragraphStyle.headIndent)
        }
        set {
            self.paragraphStyle.headIndent = CGFloat(newValue)
        }
    }
    var tailIndent: Double {
        get {
            return Double(self.paragraphStyle.tailIndent)
        }
        set {
            self.paragraphStyle.tailIndent = CGFloat(newValue)
        }
    }
    var firstLineHeadIndent: Double {
        get {
            return Double(self.paragraphStyle.firstLineHeadIndent)
        }
        set {
            self.paragraphStyle.firstLineHeadIndent = CGFloat(newValue)
        }
    }
    var minimumLineHeight: Double {
        get {
            return Double(self.paragraphStyle.minimumLineHeight)
        }
        set {
            self.paragraphStyle.minimumLineHeight = CGFloat(newValue)
        }
    }
    var maximumLineHeight: Double {
        get {
            return Double(self.paragraphStyle.maximumLineHeight)
        }
        set {
            self.paragraphStyle.maximumLineHeight = CGFloat(newValue)
        }
    }
    var lineBreakMode: NSLineBreakMode {
        get {
            return self.paragraphStyle.lineBreakMode
        }
        set {
            self.paragraphStyle.lineBreakMode = newValue
        }
    }
    var baseWritingDirection: NSWritingDirection {
        get {
            return self.paragraphStyle.baseWritingDirection
        }
        set {
            self.paragraphStyle.baseWritingDirection = newValue
        }
    }
    var lineHeightMultiple: Double {
        get {
            return Double(self.paragraphStyle.lineHeightMultiple)
        }
        set {
            self.paragraphStyle.lineHeightMultiple = CGFloat(newValue)
        }
    }
    var paragraphSpacingBefore: Double {
        get {
            return Double(self.paragraphStyle.paragraphSpacingBefore)
        }
        set {
            self.paragraphStyle.paragraphSpacingBefore = CGFloat(newValue)
        }
    }
    var hyphenationFactor: Double {
        get {
            return Double(self.paragraphStyle.hyphenationFactor)
        }
        set {
            self.paragraphStyle.hyphenationFactor = Float(newValue)
        }
    }
    var tabStops: Array<NSTextTab>? {
        get {
            return self.paragraphStyle.tabStops
        }
        set {
            self.paragraphStyle.tabStops = newValue
        }
    }
    var defaultTabInterval: Double {
        get {
            return Double(self.paragraphStyle.defaultTabInterval)
        }
        set {
            self.paragraphStyle.defaultTabInterval = CGFloat(newValue)
        }
    }
    
    // NSForegroundColorAttributeName
    var foregroundColor: UIColor? {
        get {
            return self.dictionaryRepresentation[.foregroundColor] as? UIColor
        }
        set {
            self.dictionaryRepresentation[.foregroundColor] = newValue
        }
    }
    
    // NSBackgroundColorAttributeName
    var backgroundColor: UIColor? {
        get {
            return self.dictionaryRepresentation[.backgroundColor] as? UIColor
        }
        set {
            self.dictionaryRepresentation[.backgroundColor] = newValue
        }
    }
    
    // NSLigatureAttributeName
    enum NSLigature: Int {
        case none = 0
        case `default` = 1
        case all = 2
    }
    var ligature: NSLigature? {
        get {
            if let rawValue = (self.dictionaryRepresentation[.ligature] as? NSNumber)?.int32Value {
                return NSLigature(rawValue: Int(rawValue))
            }
            return nil
        }
        set {
            if newValue != nil {
                self.dictionaryRepresentation[.ligature] = NSNumber(value: newValue!.rawValue as Int)
            } else {
                self.dictionaryRepresentation[.ligature] = nil
            }
        }
    }
    
    // NSKernAttributeName
    var kern: Double? {
        get {
            return (self.dictionaryRepresentation[.kern] as? NSNumber)?.doubleValue
        }
        set {
            if newValue != nil {
                self.dictionaryRepresentation[.kern] = NSNumber(value: newValue! as Double)
            } else {
                self.dictionaryRepresentation[.kern] = nil
            }
        }
    }
    
    // NSStrikethroughStyleAttributeName
    var strikethroughStyle: NSUnderlineStyle? {
        get {
            if let rawValue = (self.dictionaryRepresentation[.strikethroughStyle] as? NSNumber)?.int32Value {
                return NSUnderlineStyle(rawValue: Int(rawValue))
            }
            return nil
        }
        set {
            if newValue != nil {
                self.dictionaryRepresentation[.strikethroughStyle] = NSNumber(value: newValue!.rawValue as Int)
            } else {
                self.dictionaryRepresentation[.strikethroughStyle] = nil
            }
        }
    }
    
    // NSUnderlineStyleAttributeName
    var underlineStyle: NSUnderlineStyle? {
        get {
            if let rawValue = (self.dictionaryRepresentation[.underlineStyle] as? NSNumber)?.int32Value {
                return NSUnderlineStyle(rawValue: Int(rawValue))
            }
            return nil
        }
        set {
            if newValue != nil {
                self.dictionaryRepresentation[.underlineStyle] = NSNumber(value: newValue!.rawValue as Int)
            } else {
                self.dictionaryRepresentation[.underlineStyle] = nil
            }
        }
    }
    
    // NSStrokeColorAttributeName
    var strokeColor: UIColor? = nil
    
    // NSStrokeWidthAttributeName
    var strokeWidth: Double? {
        get {
            return (self.dictionaryRepresentation[.strokeWidth] as? NSNumber)?.doubleValue
        }
        set {
            if newValue != nil {
                self.dictionaryRepresentation[.strokeWidth] = NSNumber(value: newValue! as Double)
            } else {
                self.dictionaryRepresentation[.strokeWidth] = nil
            }
        }
    }
    
    // NSShadowAttributeName
    var shadow: NSShadow? {
        get {
            return self.dictionaryRepresentation[.shadow] as? NSShadow
        }
        set {
            self.dictionaryRepresentation[.shadow] = newValue
        }
    }
    
    // NSTextEffectAttributeName
    var textEffect: String? {
        get {
            return self.dictionaryRepresentation[.textEffect] as? String
        }
        set {
            self.dictionaryRepresentation[.textEffect] = newValue as AnyObject?
        }
    }
    
    // NSAttachmentAttributeName
    var attachment: NSTextAttachment? {
        get {
            return self.dictionaryRepresentation[.attachment] as? NSTextAttachment
        }
        set {
            self.dictionaryRepresentation[.attachment] = newValue
        }
    }
    
    // NSLinkAttributeName
    var link: URL? {
        get {
            return self.dictionaryRepresentation[.link] as? URL
        }
        set {
            self.dictionaryRepresentation[.link] = newValue as AnyObject?
        }
    }
    
    // NSBaselineOffsetAttributeName
    var baselineOffset: Double? {
        get {
            return (self.dictionaryRepresentation[.baselineOffset] as? NSNumber)?.doubleValue
        }
        set {
            if newValue != nil {
                self.dictionaryRepresentation[.baselineOffset] = NSNumber(value: newValue! as Double)
            } else {
                self.dictionaryRepresentation[.baselineOffset] = nil
            }
        }
    }
    
    // NSUnderlineColorAttributeName
    var underlineColor: UIColor? {
        get {
            return self.dictionaryRepresentation[.underlineColor] as? UIColor
        }
        set {
            self.dictionaryRepresentation[.underlineColor] = newValue
        }
    }
    
    // NSStrikethroughColorAttributeName
    var strikethroughColor: UIColor? {
        get {
            return self.dictionaryRepresentation[.strikethroughColor] as? UIColor
        }
        set {
            self.dictionaryRepresentation[.strikethroughColor] = newValue
        }
    }
    
    // NSObliquenessAttributeName
    var obliqueness: Double? {
        get {
            return (self.dictionaryRepresentation[.obliqueness] as? NSNumber)?.doubleValue
        }
        set {
            if newValue != nil {
                self.dictionaryRepresentation[.obliqueness] = NSNumber(value: newValue! as Double)
            } else {
                self.dictionaryRepresentation[.obliqueness] = nil
            }
        }
    }
    
    // NSExpansionAttributeName
    var expansion: Double? {
        get {
            return (self.dictionaryRepresentation[.expansion] as? NSNumber)?.doubleValue
        }
        set {
            if newValue != nil {
                self.dictionaryRepresentation[.expansion] = NSNumber(value: newValue! as Double)
            } else {
                self.dictionaryRepresentation[.expansion] = nil
            }
        }
    }
    
    // NSWritingDirectionAttributeName
    // var writingDirection: NSWritingDirection? = nil
    
    // NSVerticalGlyphFormAttributeName
    enum NSVerticalGlyphForm: Int {
        case horizontal = 0
        case vertical = 1
    }
    var verticalGlyphForm: NSVerticalGlyphForm? {
        get {
            if let rawValue = (self.dictionaryRepresentation[.verticalGlyphForm] as? NSNumber)?.int32Value {
                return NSVerticalGlyphForm(rawValue: Int(rawValue))
            }
            return nil
        }
        set {
            if newValue != nil {
                self.dictionaryRepresentation[.verticalGlyphForm] = NSNumber(value: newValue!.rawValue as Int)
            } else {
                self.dictionaryRepresentation[.verticalGlyphForm] = nil
            }
        }
    }
    
    init(dictionaryRepresentation: [String: AnyObject]? = nil) {
        if let dictionaryRepresentation = dictionaryRepresentation {
            
            var keyDictionaryRepresentation = [NSAttributedStringKey: AnyObject]()
            for (key, value) in dictionaryRepresentation {
                keyDictionaryRepresentation[NSAttributedStringKey(rawValue: key)] = value
            }
            
            self.dictionaryRepresentation = keyDictionaryRepresentation
        }
    }
    
}

final class AttributedStringMakerContext {
    fileprivate let attributedString = NSMutableAttributedString()
    fileprivate let attributes = AttributedStringMakerAttributes()
    fileprivate var attributesStack = [[NSAttributedStringKey: AnyObject]]()
    
    func append(_ string: String?) {
        if string != nil {
            let attributedString = NSAttributedString(string: string!, attributes: self.attributes.dictionaryRepresentation)
            self.attributedString.append(attributedString)
        }
    }
    
    func append(_ string: NSAttributedString?) {
        if string != nil {
            self.attributedString.append(string!)
        }
    }
    
    func saveState() {
        self.attributesStack.append(self.attributes.dictionaryRepresentation)
    }
    
    func restoreState() {
        if self.attributesStack.count > 0 {
            self.attributes.dictionaryRepresentation = self.attributesStack.removeLast()
        }
    }
}

func AttributedStringAttributesMake(_ closure: (_ attrs: AttributedStringMakerAttributes) -> Void) -> [NSAttributedStringKey: AnyObject] {
    let ctx = AttributedStringMakerContext()
    closure(ctx.attributes)
    return ctx.attributes.dictionaryRepresentation
}

func AttributedStringMake(_ closure: (_ attrs: AttributedStringMakerAttributes, _ ctx: AttributedStringMakerContext) -> Void) -> NSAttributedString {
    let ctx = AttributedStringMakerContext()
    closure(ctx.attributes, ctx)
    return ctx.attributedString
}
