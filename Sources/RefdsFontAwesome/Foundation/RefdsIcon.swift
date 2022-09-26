import Foundation

public struct RefdsIcon: Identifiable, Decodable, Comparable {
    public var id: String?
    public var label: RefdsIconLabel
    public var styles: [RefdsIconStyle]
    public var unicode: String
    public var searchTerms: [String]
    
    var unicodeString: String {
        let rawMutable = NSMutableString(string: "\\u\(unicode)")
        CFStringTransform(rawMutable, nil, "Any-Hex/Java" as NSString, true)
        return rawMutable as String
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let labelString = try values.decodeIfPresent(String.self, forKey: .label) ?? "none"
        label = RefdsIconLabel(rawValue: labelString) ?? .none
        unicode = try values.decode(String.self, forKey: .unicode)
        styles = try values.decode([RefdsIconStyle].self, forKey: .styles)
        
        let search = try values.nestedContainer(keyedBy: SearchKeys.self, forKey: .search)
        searchTerms = try search.decodeIfPresent([String].self, forKey: .terms) ?? []
    }
    
    public enum CodingKeys: String, CodingKey {
        case label
        case unicode
        case styles
        case search
    }
    
    public enum SearchKeys: String, CodingKey {
        case terms
    }
    
    enum RawSearchTerm: Decodable {
        case int(Int)
        case string(String)
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            do {
                self = try .int(container.decode(Int.self))
            } catch DecodingError.typeMismatch {
                do {
                    self = try .string(container.decode(String.self))
                } catch DecodingError.typeMismatch {
                    throw DecodingError.typeMismatch(RawSearchTerm.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Encoded payload conflicts with expected type, (Int or String)"))
                }
            }
        }
        
        func toString() -> String {
            switch self {
            case .int(let storedInt): return String(storedInt)
            case .string(let storedString): return storedString
            }
        }
    }
    
    public static func < (lhs: RefdsIcon, rhs: RefdsIcon) -> Bool {
        return lhs.unicode < lhs.unicode
    }
    
    public static func == (lhs: RefdsIcon, rhs: RefdsIcon) -> Bool {
        return lhs.unicode == lhs.unicode
    }
}
