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
        default: return .regular
        }
    }
}
