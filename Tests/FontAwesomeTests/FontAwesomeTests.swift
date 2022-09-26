import XCTest
@testable import RefdsFontAwesome

final class FontAwesomeTests: XCTestCase {
    func testDecoding() {
        let fontAwesome = FontAwesome.shared.store
        print(fontAwesome)
    }
}
