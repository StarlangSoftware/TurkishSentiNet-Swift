import XCTest
@testable import SentiNet

final class SentiNetTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SentiNet().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
