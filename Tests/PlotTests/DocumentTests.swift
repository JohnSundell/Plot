/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import XCTest
import Plot

final class DocumentTests: XCTestCase {
    func testEmptyDocument() {
        let document = Document<FormatStub>.custom()
        XCTAssertEqual(document.render(), "")
    }

    func testEmptyIndentedDocument() {
        let document = Document<FormatStub>.custom()
        XCTAssertEqual(document.render(indentedBy: .spaces(4)), "")
    }

    func testIndentationWithSpaces() {
        let document = Document.custom(
            withFormat: FormatStub.self,
            elements: [
                .named("one", nodes: [
                    .element(named: "two", nodes: [
                        .selfClosedElement(named: "three")
                    ])
                ]),
                .selfClosed(named: "four", attributes: [
                    Attribute(name: "key", value: "value")
                ])
            ]
        )

        XCTAssertEqual(document.render(indentedBy: .spaces(4)), """
        <one>
            <two>
                <three/>
            </two>
        </one>
        <four key="value"/>
        """)
    }

    func testIndentationWithTabs() {
        let document = Document.custom(
            withFormat: FormatStub.self,
            elements: [
                .named<FormatStub.RootContext>("one", nodes: [
                    .element<FormatStub.RootContext>(named: "two", nodes: [
                        .selfClosedElement(named: "three")
                    ])
                ]),
                .selfClosed(named: "four", attributes: [
                    Attribute(name: "key", value: "value")
                ])
            ]
        )

        XCTAssertEqual(document.render(indentedBy: .tabs(1)), """
        <one>
        \t<two>
        \t\t<three/>
        \t</two>
        </one>
        <four key="value"/>
        """)
    }
}

private extension DocumentTests {
    struct FormatStub: DocumentFormat {
        enum RootContext {}
    }
}

extension DocumentTests {
    static var allTests: Linux.TestList<DocumentTests> {
        [
            ("testEmptyDocument", testEmptyDocument),
            ("testEmptyIndentedDocument", testEmptyIndentedDocument),
            ("testIndentationWithSpaces", testIndentationWithSpaces),
            ("testIndentationWithTabs", testIndentationWithTabs)
        ]
    }
}
