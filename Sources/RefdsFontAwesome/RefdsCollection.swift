import SwiftUI

enum RefdsCollection: String {
    case pro = "Font-Awesome-6-Pro"
    case brands = "Font-Awesome-6-Brands"
    
    static var availableCollection: [RefdsCollection] {
        var result = [RefdsCollection]()
        if RefdsCollection.isAvailable(collection: .pro) {
            result.append(.pro)
        }
        
        if RefdsCollection.isAvailable(collection: .brands) {
            result.append(.brands)
        }
        return result
    }
    
    static func isAvailable(collection: RefdsCollection) -> Bool {
        #if os(iOS)
            return UIFont.familyNames.contains(collection.rawValue)
        #elseif os(OSX)
            return NSFontManager.shared.availableFontFamilies.contains(collection.rawValue)
        #endif
    }
}
