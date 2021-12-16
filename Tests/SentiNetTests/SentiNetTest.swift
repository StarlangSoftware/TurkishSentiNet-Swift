import XCTest
@testable import SentiNet

final class SentiNetTest: XCTestCase {
    var sentiNet : SentiNet = SentiNet()
    
    override public func setUp(){
        self.sentiNet = SentiNet()
    }

    public func testGetPositives() {
        XCTAssertEqual(3100, self.sentiNet.getPositives().count)
    }

    public func testGetNegatives() {
        XCTAssertEqual(10191, self.sentiNet.getNegatives().count)
    }

    public func testGetNeutrals() {
        XCTAssertEqual(63534, self.sentiNet.getNeutrals().count)
    }

    static var allTests = [
        ("testExample1", testGetPositives),
        ("testExample2", testGetNegatives),
        ("testExample3", testGetNeutrals),
    ]
}
