import SwiftUI

public struct RefdsFontAwesome: View {
    var iconName: RefdsIconLabel
    private var icon: RefdsIcon
    var size: CGFloat
    var style: RefdsIconStyle
    var color: Color
    
    public init(iconName: RefdsIconLabel, size: CGFloat, style: RefdsIconStyle? = nil, color: Color = Color(UIColor.label)) {
        self.size = size
        self.style = style ?? .regular
        self.iconName = iconName
        self.color = color
        
        if let icon = FontAwesome.shared.icon(byName: iconName) {
            self.icon = icon
        } else {
            self.icon = FontAwesome.shared.icon(byName: .circleQuestion)!
            self.style = .regular
        }
        
        if !self.icon.styles.contains(self.style) {
            let fallbackStyle = self.icon.styles.first!
            if fallbackStyle != .brands && style != nil {
                print("[RefdsFontAwesome] Style \"\(style ?? .regular)\" not available for icon \"\(iconName)\", using \"\(fallbackStyle)\". Check list at https://fontawesome.com/icons for set availability.")
            } else if self.style != .regular && style != nil {
                print("[RefdsFontAwesome] Icon \"\(iconName)\" is part of the brands set and doesn't support alternate styles. Check list at https://fontawesome.com/icons for set availability.")
            }
            self.style = fallbackStyle
        }
    }
    
    public var body: some View {
        if style == .duotone {
            Image(uiImage: fontAwesome(icon: icon, style: .duotone, textColor: color, size: CGSize(width: size, height: size)))
        } else {
            Text(icon.unicodeString)
                .font(.refds(size: size, style: style))
                .foregroundColor(color)
        }
    }
    
    func fontAwesome(icon: RefdsIcon, style: RefdsIconStyle = .regular, textColor: Color, size: CGSize, backgroundColor: Color = .clear, borderWidth: CGFloat = 0, borderColor: UIColor = UIColor.clear) -> UIImage {
        var size = size
        if size.width <= 0 { size.width = 1 }
        if size.height <= 0 { size.height = 1 }
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = NSTextAlignment.center
        
        let fontSize = min(size.width / 1.28571429, size.height)
        let strokeWidth: CGFloat = fontSize == 0 ? 0 : (-100 * borderWidth / fontSize)
        
        let attributedString = NSAttributedString(string: icon.unicodeString, attributes: [
            NSAttributedString.Key.font: Font.custom(icon.unicodeString, size: fontSize),
            NSAttributedString.Key.foregroundColor: textColor,
            NSAttributedString.Key.backgroundColor: backgroundColor,
            NSAttributedString.Key.paragraphStyle: paragraph,
            NSAttributedString.Key.strokeWidth: strokeWidth,
            NSAttributedString.Key.strokeColor: borderColor
        ])
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        attributedString.draw(in: CGRect(x: 0, y: (size.height - fontSize) / 2, width: size.width, height: fontSize))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
