////
////  PublicAPI.swift
////  PlotTests
////
////  Created by Klaus Kneupner on 27/03/2020.
////
//
//import Plot
//import XCTest
//
//
/////Idea is to test the public API. Proposed is a simple example, that only used API functions.
//
//
//// MARK: - Format Definition
/////
////////DocumentFormat
//public struct TestDoc: DocumentFormat {
//    private let document: Document<TestDoc>
//
//    public init(_ nodes: Node<TestDoc.ItemContext>...) {
//        document = Document.custom(
//            .test(.group(nodes))
//        )
//    }
//}
//
//extension TestDoc: Renderable {
//    public func render(indentedBy indentationKind: Indentation.Kind?) -> String {
//        document.render(indentedBy: indentationKind)
//    }
//}
//
//public extension TestDoc {
//    enum RootContext: XMLRootContext {}
//    enum ItemContext {}
//}
//
//// MARK: - Elements
//public extension Element where Context == TestDoc.RootContext {
//    static func test(_ nodes: Node<TestDoc.ItemContext>...) -> Element<TestDoc.RootContext>  {
//  //      let n = nodes[0] as Node<Any>
//        return Element.named("test", nodes: nodes)
//    }
//}
//
//public extension Node where Context == TestDoc.ItemContext {
//    static func item(_ nodes: Node<TestDoc.ItemContext>...) -> Node {
//        .element(named: "item", nodes: nodes)
//    }
//}
//
//// MARK: - Attributes
//public extension Node where Context == TestDoc.ItemContext {
//    static func id( _ id: String) -> Node {
//        .attribute(named: "id", value: id)
//    }
//}
//
//
//// MARK: - Test Cases
//final class PublicAPI: XCTestCase {
//    func testAPI() {
//        let test1 = TestDoc(.item(.id("123")))
//        XCTAssertEqual(test1.render(indentedBy: .none), "<test><item id=\"123\"/><test/>")
//    }
//
//    static var allTests = [
//        ("testAPI", testAPI),
//    ]
//}
//
//
