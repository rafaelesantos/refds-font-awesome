import UIKit
import SwiftUI

public extension Font {
    static var refdsFontNames: [RefdsIconStyle: String] = [:]
    
    static var refdsFonts: [RefdsIconStyle: URL?] =  [
        .thin: Bundle.current.url(forResource: "Font-Awesome-6-Pro-Thin-100.otf", withExtension: nil),
        .light: Bundle.current.url(forResource: "Font-Awesome-6-Pro-Light-300.otf", withExtension: nil),
        .regular: Bundle.current.url(forResource: "Font-Awesome-6-Pro-Regular-400.otf", withExtension: nil),
        .solid: Bundle.current.url(forResource: "Font-Awesome-6-Pro-Solid-900.otf", withExtension: nil),
        .brands: Bundle.current.url(forResource: "Font-Awesome-6-Brands-Regular-400.otf", withExtension: nil),
        .duotone: Bundle.current.url(forResource: "Font-Awesome-6-Pro-Duotone-Solid-900.otf", withExtension: nil),
    ]

    static func refds(size: CGFloat, style: RefdsIconStyle) -> Font {
        if refdsFontNames.isEmpty {
            Font.registerRefdsFonts()
            return refds(size: size, style: style)
        }
        guard let fontName = refdsFontNames[style] else {
            assertionFailure("Unsupported font style")
            return nonScalingSystemFont(size: size)
        }
        return .custom(fontName, size: size)
    }

    static func registerRefdsFonts() {
        for case let (style, url?) in refdsFonts {
            guard let font = registerFont(at: url) else { continue }
            refdsFontNames[style] = font.postScriptName as String?
        }
    }

    static func registerFont(at url: URL) -> CGFont? {
        guard let data = try? Data(contentsOf: url),
              let dataProvider = CGDataProvider(data: data as CFData),
              let font = CGFont(dataProvider)
        else {
            fatalError("Unable to load custom font from \(url)")
        }

        var error: Unmanaged<CFError>?
        if CTFontManagerRegisterGraphicsFont(font, &error) == false {
            print("Custom font registration error: \(String(describing: error))")
        }

        return font
    }

    private static func nonScalingSystemFont(size: CGFloat) -> Font {
        .system(size: size)
    }
}
