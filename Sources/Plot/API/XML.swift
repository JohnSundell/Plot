/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

/// A representation of an XML document. Create an instance of this
/// type to build a web page using Plot's type-safe DSL, and then
/// call the `render()` method to turn it into an XML string.
public struct XML: DocumentFormat {
    private let document: Document<XML>

    /// Create an XML document with a collection of nodes that make
    /// up its elements and attributes. Since the core XML format
    /// is very free-form, you'll either define elements using the
    /// `.element()` APIs, or by creating your own context-bound
    /// components by extending the `Node` type.
    /// - parameter nodes: The root nodes of the document.
    public init(_ nodes: Node<XML.DocumentContext>...) {
        document = Document(elements: [
            .xml(.version(1.0), .encoding(.utf8)),
            Element(name: "", nodes: nodes)
        ])
    }
}

extension XML: NodeConvertible {
    public var node: Node<Self> { document.node }
}

public extension XML {
    /// The root context of an XML document.
    enum RootContext: XMLRootContext {}
    /// The context within an XML document's `<xml>` declaration.
    enum DeclarationContext {}
    /// The user-facing root context of an XML document.
    enum DocumentContext {}
}

/// Protocol adopted by all contexts that are at the root level of
/// an XML-based document format.
public protocol XMLRootContext {}
