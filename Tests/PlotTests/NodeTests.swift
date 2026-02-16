/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import XCTest
import Plot

final class NodeTests: XCTestCase {
    func testEscapingText() {
        let node = Node<Any>.text("Hello & welcome to <Plot>!;")
        XCTAssertEqual(node.render(), "Hello &amp; welcome to &lt;Plot&gt;!;")
    }

    func testEscapingDoubleAmpersands() {
        let node = Node<Any>.text("&&")
        XCTAssertEqual(node.render(), "&amp;&amp;")
    }

    func testEscapingAmpersandFollowedByComparisonSymbols() {
        let node = Node<Any>.text("&< &>")
        XCTAssertEqual(node.render(), "&amp;&lt; &amp;&gt;")
    }

    func testNotDoubleEscapingText() {
        let node = Node<Any>.text("Hello &amp; welcome&#160;to &lt;Plot&gt;!&text")
        XCTAssertEqual(node.render(), "Hello &amp; welcome&#160;to &lt;Plot&gt;!&amp;text")
    }

    func testNotEscapingRawString() {
        let node = Node<Any>.raw("Hello & welcome to <Plot>!")
        XCTAssertEqual(node.render(), "Hello & welcome to <Plot>!")
    }

    func testGroup() {
        let node = Node<Any>.group(.text("Hello"), .text("World"))
        XCTAssertEqual(node.render(), "HelloWorld")
    }

    func testCustomElement() {
        let node = Node<Any>.element(named: "custom")
        XCTAssertEqual(node.render(), "<custom></custom>")
    }

    func testCustomAttribute() {
        let node = Node<Any>.attribute(named: "key", value: "value")
        XCTAssertEqual(node.render(), #"key="value""#)
    }

    func testEscapingDoubleQuotesInAttributeValue() {
        let node = Node<Any>.attribute(named: "key", value: #"a"b"#)
        XCTAssertEqual(node.render(), #"key="a&quot;b""#)
    }

    func testEscapingSingleQuotesInAttributeValue() {
        let node = Node<Any>.attribute(named: "key", value: "a'b")
        XCTAssertEqual(node.render(), #"key="a&#39;b""#)
    }

    func testEscapingAngleBracketsInAttributeValue() {
        let node = Node<Any>.attribute(named: "key", value: "<script>alert(1)</script>")
        XCTAssertEqual(node.render(), #"key="&lt;script&gt;alert(1)&lt;/script&gt;""#)
    }

    func testEscapingAmpersandInAttributeValue() {
        let node = Node<Any>.attribute(named: "key", value: "a&b")
        XCTAssertEqual(node.render(), #"key="a&amp;b""#)
    }

    func testNotDoubleEscapingAttributeValue() {
        let node = Node<Any>.attribute(named: "key", value: "&amp;")
        XCTAssertEqual(node.render(), #"key="&amp;""#)
    }

    func testEscapingXSSInAttributeValue() {
        let node = Node<Any>.attribute(
            named: "value",
            value: #""><img src=x onerror=alert(1)><input value=""#
        )
        XCTAssertEqual(
            node.render(),
            #"value="&quot;&gt;&lt;img src=x onerror=alert(1)&gt;&lt;input value=&quot;""#
        )
    }

    func testCustomElementWithCustomAttribute() {
        let node = Node<Any>.element(named: "custom", attributes: [
            Attribute(name: "key", value: "value")
        ])

        XCTAssertEqual(node.render(), #"<custom key="value"></custom>"#)
    }

    func testCustomElementWithCustomAttributeWithSpecificContext() {
        let node = Node<Any>.element(named: "custom", attributes: [
            Attribute<String>(name: "key", value: "value")
        ])

        XCTAssertEqual(node.render(), #"<custom key="value"></custom>"#)
    }

    func testCustomSelfClosedElementWithCustomAttribute() {
        let node = Node<Any>.selfClosedElement(named: "custom", attributes: [
            Attribute(name: "key", value: "value")
        ])

        XCTAssertEqual(node.render(), #"<custom key="value"/>"#)
    }

    func testComponents() {
        let node = Node<Any>.components {
            Paragraph("One")
            Paragraph("Two")
        }

        XCTAssertEqual(node.render(), "<p>One</p><p>Two</p>")
    }

    func testNodeComponentBodyIsEqualToSelf() {
        let node = Node.p("Text")
        XCTAssertEqual(node.render(), node.body.render())
    }
}
