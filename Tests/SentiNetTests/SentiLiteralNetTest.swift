import XCTest
@testable import SentiNet

final class SentiLiteralNetTest: XCTestCase {
    var sentiNet : SentiLiteralNet = SentiLiteralNet()
    
    override public func setUp(){
        self.sentiNet = SentiLiteralNet(fileName: "turkish_sentiliteralnet.xml")
    }

    public func testGetPositives() {
        XCTAssertEqual(4335, self.sentiNet.getPositives().count)
    }

    public func testGetNegatives() {
        XCTAssertEqual(13011, self.sentiNet.getNegatives().count)
    }

    public func testGetNeutrals() {
        XCTAssertEqual(62379, self.sentiNet.getNeutrals().count)
    }

    static var allTests = [
        ("testExample1", testGetPositives),
        ("testExample2", testGetNegatives),
        ("testExample3", testGetNeutrals),
    ]
}
