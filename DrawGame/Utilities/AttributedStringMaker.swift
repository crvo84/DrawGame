import UIKit

final class AttributedStringMakerAttributes {
    
    // Dictionary
    fileprivate(set) var dictionaryRepresentation = [String: AnyObject]()
    
    // NSFontAttributeName
    var font: UIFont? {
        get {
            return self.dictionaryRepresentation[NSFontAttributeName] as? UIFont
        }
        set {
            self.dictionaryRepresentation[NSFontAttributeName] = newValue
        }
    }
    
    // NSParagraphStyleAttributeName
    fileprivate(set) var paragraphStyle: NSMutableParagraphStyle {
        get {
            var ps = self.dictionaryRepresentation[NSParagraphStyleAttributeName] as? NSMutableParagraphStyle
            if ps == nil {
                ps = NSMutableParagraphStyle()
                self.dictionaryRepresentation[NSParagraphStyleAttributeName] = ps
            }
            return ps!
        }
        set {
            self.dictionaryRepresentation[NSParagraphStyleAttributeName] = newValue.mutableCopy() as AnyObject?
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
            return self.dictionaryRepresentation[NSForegroundColorAttributeName] as? UIColor
        }
        set {
            self.dictionaryRepresentation[NSForegroundColorAttributeName] = newValue
        }
    }
    
    // NSBackgroundColorAttributeName
    var backgroundColor: UIColor? {
        get {
            return self.dictionaryRepresentation[NSBackgroundColorAttributeName] as? UIColor
        }
        set {
            self.dictionaryRepresentation[NSBackgroundColorAttributeName] = newValue
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
            if let rawValue = (self.dictionaryRepresentation[NSLigatureAttributeName] as? NSNumber)?.int32Value {
                return NSLigature(rawValue: Int(rawValue))
            }
            return nil
        }
        set {
            if newValue != nil {
                self.dictionaryRepresentation[NSLigatureAttributeName] = NSNumber(value: newValue!.rawValue as Int)
            } else {
                self.dictionaryRepresentation[NSLigatureAttributeName] = nil
            }
        }
    }
    
    // NSKernAttributeName
    var kern: Double? {
        get {
            return (self.dictionaryRepresentation[NSKernAttributeName] as? NSNumber)?.doubleValue
        }
        set {
            if newValue != nil {
                self.dictionaryRepresentation[NSKernAttributeName] = NSNumber(value: newValue! as Double)
            } else {
                self.dictionaryRepresentation[NSKernAttributeName] = nil
            }
        }
    }
    
    // NSStrikethroughStyleAttributeName
    var strikethroughStyle: NSUnderlineStyle? {
        get {
            if let rawValue = (self.dictionaryRepresentation[NSStrikethroughStyleAttributeName] as? NSNumber)?.int32Value {
                return NSUnderlineStyle(rawValue: Int(rawValue))
            }
            return nil
        }
        set {
            if newValue != nil {
                self.dictionaryRepresentation[NSStrikethroughStyleAttributeName] = NSNumber(value: newValue!.rawValue as Int)
            } else {
                self.dictionaryRepresentation[NSStrikethroughStyleAttributeName] = nil
            }
        }
    }
    
    // NSUnderlineStyleAttributeName
    var underlineStyle: NSUnderlineStyle? {
        get {
            if let rawValue = (self.dictionaryRepresentation[NSUnderlineStyleAttributeName] as? NSNumber)?.int32Value {
                return NSUnderlineStyle(rawValue: Int(rawValue))
            }
            return nil
        }
        set {
            if newValue != nil {
                self.dictionaryRepresentation[NSUnderlineStyleAttributeName] = NSNumber(value: newValue!.rawValue as Int)
            } else {
                self.dictionaryRepresentation[NSUnderlineStyleAttributeName] = nil
            }
        }
    }
    
    // NSStrokeColorAttributeName
    var strokeColor: UIColor? = nil
    
    // NSStrokeWidthAttributeName
    var strokeWidth: Double? {
        get {
            return (self.dictionaryRepresentation[NSStrokeWidthAttributeName] as? NSNumber)?.doubleValue
        }
        set {
            if newValue != nil {
                self.dictionaryRepresentation[NSStrokeWidthAttributeName] = NSNumber(value: newValue! as Double)
            } else {
                self.dictionaryRepresentation[NSStrokeWidthAttributeName] = nil
            }
        }
    }
    
    // NSShadowAttributeName
    var shadow: NSShadow? {
        get {
            return self.dictionaryRepresentation[NSShadowAttributeName] as? NSShadow
        }
        set {
            self.dictionaryRepresentation[NSShadowAttributeName] = newValue
        }
    }
    
    // NSTextEffectAttributeName
    var textEffect: String? {
        get {
            return self.dictionaryRepresentation[NSTextEffectAttributeName] as? String
        }
        set {
            self.dictionaryRepresentation[NSTextEffectAttributeName] = newValue as AnyObject?
        }
    }
    
    // NSAttachmentAttributeName
    var attachment: NSTextAttachment? {
        get {
            return self.dictionaryRepresentation[NSAttachmentAttributeName] as? NSTextAttachment
        }
        set {
            self.dictionaryRepresentation[NSAttachmentAttributeName] = newValue
        }
    }
    
    // NSLinkAttributeName
    var link: URL? {
        get {
            return self.dictionaryRepresentation[NSLinkAttributeName] as? URL
        }
        set {
            self.dictionaryRepresentation[NSLinkAttributeName] = newValue as AnyObject?
        }
    }
    
    // NSBaselineOffsetAttributeName
    var baselineOffset: Double? {
        get {
            return (self.dictionaryRepresentation[NSBaselineOffsetAttributeName] as? NSNumber)?.doubleValue
        }
        set {
            if newValue != nil {
                self.dictionaryRepresentation[NSBaselineOffsetAttributeName] = NSNumber(value: newValue! as Double)
            } else {
                self.dictionaryRepresentation[NSBaselineOffsetAttributeName] = nil
            }
        }
    }
    
    // NSUnderlineColorAttributeName
    var underlineColor: UIColor? {
        get {
            return self.dictionaryRepresentation[NSUnderlineColorAttributeName] as? UIColor
        }
        set {
            self.dictionaryRepresentation[NSUnderlineColorAttributeName] = newValue
        }
    }
    
    // NSStrikethroughColorAttributeName
    var strikethroughColor: UIColor? {
        get {
            return self.dictionaryRepresentation[NSStrikethroughColorAttributeName] as? UIColor
        }
        set {
            self.dictionaryRepresentation[NSStrikethroughColorAttributeName] = newValue
        }
    }
    
    // NSObliquenessAttributeName
    var obliqueness: Double? {
        get {
            return (self.dictionaryRepresentation[NSObliquenessAttributeName] as? NSNumber)?.doubleValue
        }
        set {
            if newValue != nil {
                self.dictionaryRepresentation[NSObliquenessAttributeName] = NSNumber(value: newValue! as Double)
            } else {
                self.dictionaryRepresentation[NSObliquenessAttributeName] = nil
            }
        }
    }
    
    // NSExpansionAttributeName
    var expansion: Double? {
        get {
            return (self.dictionaryRepresentation[NSExpansionAttributeName] as? NSNumber)?.doubleValue
        }
        set {
            if newValue != nil {
                self.dictionaryRepresentation[NSExpansionAttributeName] = NSNumber(value: newValue! as Double)
            } else {
                self.dictionaryRepresentation[NSExpansionAttributeName] = nil
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
            if let rawValue = (self.dictionaryRepresentation[NSVerticalGlyphFormAttributeName] as? NSNumber)?.int32Value {
                return NSVerticalGlyphForm(rawValue: Int(rawValue))
            }
            return nil
        }
        set {
            if newValue != nil {
                self.dictionaryRepresentation[NSVerticalGlyphFormAttributeName] = NSNumber(value: newValue!.rawValue as Int)
            } else {
                self.dictionaryRepresentation[NSVerticalGlyphFormAttributeName] = nil
            }
        }
    }
    
    init(dictionaryRepresentation: [String: AnyObject]? = nil) {
        if dictionaryRepresentation != nil {
            self.dictionaryRepresentation = dictionaryRepresentation!
        }
    }
    
}

final class AttributedStringMakerContext {
    fileprivate let attributedString = NSMutableAttributedString()
    fileprivate let attributes = AttributedStringMakerAttributes()
    fileprivate var attributesStack = [[String: AnyObject]]()
    
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

func AttributedStringAttributesMake(_ closure: (_ attrs: AttributedStringMakerAttributes) -> Void) -> [String: AnyObject] {
    let ctx = AttributedStringMakerContext()
    closure(ctx.attributes)
    return ctx.attributes.dictionaryRepresentation
}

func AttributedStringMake(_ closure: (_ attrs: AttributedStringMakerAttributes, _ ctx: AttributedStringMakerContext) -> Void) -> NSAttributedString {
    let ctx = AttributedStringMakerContext()
    closure(ctx.attributes, ctx)
    return ctx.attributedString
}
