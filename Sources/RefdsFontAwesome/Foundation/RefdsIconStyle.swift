import SwiftUI

public enum RefdsIconStyle: String, Codable {
    case light
    case regular
    case solid
    case brands
    case duotone
    case thin
    
    var weight: Font.Weight {
        switch self {
        case .light: return .light
        case .solid: return .heavy
        default: return .regular
        }
    }
}
