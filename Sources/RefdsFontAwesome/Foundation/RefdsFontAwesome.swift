import SwiftUI

public struct RefdsFontAwesome: View {
    var iconName: RefdsIconLabel
    private var icon: RefdsIcon
    var size: CGFloat
    var style: RefdsIconStyle
    var color: Color
    
    private var weight: Font.Weight {
        return style.weight
    }
    
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
        Text(icon.unicodeString)
            .font(.refds(size: size, weight: weight, style: style))
            .foregroundColor(color)
    }
}
