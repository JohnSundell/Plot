import XCTest
import Plot

final class PlotSVGTests: XCTestCase {
    func testSVGLength() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        var length: SVGLengthQuantity = 10.0
        XCTAssertEqual(length.unit, .none)
        XCTAssertEqual(length.value, 10.0)
        
        length = 10
        XCTAssertEqual(length.unit, .none)
        XCTAssertEqual(length.value, 10.0)
        
        length = "10pt"
        XCTAssertEqual(length.unit, .point)
        XCTAssertEqual(length.value, 10.0)
        
        length = "15.3px"
        XCTAssertEqual(length.unit, .pixel)
        XCTAssertEqual(length.value, 15.3)
        
        
        length = "17.32323E5 mm"
        XCTAssertEqual(length.unit, .millimeter)
        XCTAssertEqual(length.value, 1732323)
        XCTAssertEqual(length.asString(), "1732323.00mm")
        
        let test1 = SVGDoc(.viewport("0 0 100 100"),.g(.svg(.x(10), .y("10em"), .width("2.5px"),.height("19.4"), .g(),.path())))
        print(test1.render())
    }
}
extension PlotSVGTests {
    static var allTests : Linux.TestList<PlotSVGTests> = [
        ("testSVGLength", testSVGLength)
    ]
    
    
}
