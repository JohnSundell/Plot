import XCTest
import Plot

final class PlotSVGTests: XCTestCase {
    func testSVGLength() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        var length: SVGLength = 10.0
        XCTAssertEqual(length.unit, .none)
        XCTAssertEqual(length.value, 10.0)
        
        length = 10
        XCTAssertEqual(length.unit, .none)
        XCTAssertEqual(length.value, 10.0)
        
        length = "10pt"
        XCTAssertEqual(length.unit, .points)
        XCTAssertEqual(length.value, 10.0)
        
        length = "15.3px"
        XCTAssertEqual(length.unit, .pixels)
        XCTAssertEqual(length.value, 15.3)
        
        let test1 = SVGDoc(.viewport("0 0 100 100"),.g(.g(.g(),.path())))
        print(test1.render())
    }
}
extension PlotSVGTests {
    static var allTests : Linux.TestList<PlotSVGTests> = [
        ("testSVGLength", testSVGLength)
    ]
    
    
}
