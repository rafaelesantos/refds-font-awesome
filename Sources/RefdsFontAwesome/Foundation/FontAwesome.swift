import Foundation

public class FontAwesome {
    public static var shared: FontAwesome = FontAwesome()
    public private(set) var store: [String: RefdsIcon]
    
    init() {
        let fileURL = Bundle.current.url(forResource: "icons.json", withExtension: nil)!
        let jsonString = try! String(contentsOf: fileURL, encoding: .utf8)
        let jsonData = jsonString.data(using: .utf8)!
        self.store = try! JSONDecoder().decode([String: RefdsIcon].self, from: jsonData)
        for key in store.keys { store[key]!.id = key }
    }
    
    public func icon(byName name: RefdsIconLabel) -> RefdsIcon? {
        return store[name.rawValue.lowercased()]
    }
    
    public func search(query: String) -> [RefdsIcon] {
        let query = query.lowercased()
        let filtered = store.filter() {
            if $0.key.contains(query) {
                return true
            } else {
                for term in $0.value.searchTerms {
                    if term.contains(query) { return true }
                }
                return false
            }
        }
        return filtered.values.map({ $0 })
    }
}
