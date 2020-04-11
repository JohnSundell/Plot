import XCTest
import Plot

final class plotSVGTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        var length: SVGLength = 10.0
        XCTAssertEqual(length.unit, .none)
        
        length = 10
        XCTAssertEqual(length.unit, .none)
        
        length = "10pt"
        XCTAssertEqual(length.unit, .points)
        
        let test1 = SVGDoc(.viewport("0 0 100 100"),.g(.g(.g(),.path())))
        print(test1.render())
    }

    static var allTests = [
        ("testExample", testExample),
    ]
    
    
}
