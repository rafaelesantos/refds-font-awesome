import SwiftUI

public struct RefdsFontAwesome: View {
    var iconName: RefdsIconLabel
    private var icon: RefdsIcon
    var size: CGFloat
    var style: RefdsIconStyle
    
    private var weight: Font.Weight {
        return style.weight
    }
    
    public init(iconName: RefdsIconLabel, size: CGFloat, style: RefdsIconStyle? = nil) {
        self.size = size
        self.style = style ?? .regular
        self.iconName = iconName
        
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
            .font(Font.custom("Font-Awesome-6-Pro", size: size))
            .fontWeight(weight)
    }
}
