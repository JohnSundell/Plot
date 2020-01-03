import XCTest
import Plot

final class IndentationTests: XCTestCase {
    func testSpacesCoding() throws {
        let indentation = Indentation(kind: .spaces(4))
        let data = try JSONEncoder().encode(indentation)
        let decoded = try JSONDecoder().decode(Indentation.self, from: data)
        XCTAssertEqual(indentation, decoded)
    }

    func testTabsCoding() throws {
        let indentation = Indentation(kind: .tabs(1))
        let data = try JSONEncoder().encode(indentation)
        let decoded = try JSONDecoder().decode(Indentation.self, from: data)
        XCTAssertEqual(indentation, decoded)
    }
}

extension IndentationTests {
    static var allTests: Linux.TestList<IndentationTests> {
        [
            ("testSpacesCoding", testSpacesCoding),
            ("testTabsCoding", testTabsCoding)
        ]
    }
}
