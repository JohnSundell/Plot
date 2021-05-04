/**
*  Plot
*  Copyright (c) John Sundell 2020
*  MIT license, see LICENSE file for details
*/

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

    func testDecodingErrorForInvalidKind() throws {
        func makeData(withKind kind: String) -> Data {
            Data(#"{"kind":"\#(kind)","count": 3}"#.utf8)
        }

        let decoder = JSONDecoder()
        let validData = makeData(withKind: "spaces")
        let invalidData = makeData(withKind: "invalid")

        XCTAssertNoThrow(
            try decoder.decode(Indentation.Kind.self, from: validData)
        )

        XCTAssertThrowsError(
            try decoder.decode(Indentation.Kind.self, from: invalidData)
        )
    }
}
