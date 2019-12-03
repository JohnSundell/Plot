/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Foundation

/// A representation of an element within a document, such as an HTML or XML tag.
/// You normally don't construct `Element` values manually, but rather use Plot's
/// various DSL APIs to create them, for example by creating a `<body>` tag using
/// `.body()`, or a `<p>` tag using `.p()`.
public struct Element<Context> {
    /// The name of the element
    public var name: String
    /// How the element is closed, for example if it's self-closing or if it can
    /// contain child elements.
    public var closingMode: ClosingMode = .standard

    internal var nodes: [AnyNode]
    internal var paddingCharacter: Character? = nil
}

public extension Element {
    /// Enum defining how a given element should be closed
    enum ClosingMode {
        /// The standard (default) closing mode, which creates a pair of opening
        /// and closing tags, for example `<html></html>`.
        case standard
        /// For elements that are never closed, for example the leading declaration
        /// tags found at the top of XML documents.
        case neverClosed
        /// For elements that close themselves, for example `<img src="..."/>`.
        case selfClosing
    }

    /// Create a custom element with a given name and array of child nodes.
    /// - parameter name: The name of the element to create.
    /// - parameter nodes: The nodes (child elements + attributes) to add to the element.
    static func named(_ name: String, nodes: [Node<Any>]) -> Element {
        Element(name: name, nodes: nodes)
    }

    /// Create a custom self-closed element with a given name and array of attributes.
    /// - parameter name: The name of the element to create.
    /// - parameter attributes The attributes to add to the element.
    static func selfClosed(named name: String,
                           attributes: [Attribute<Any>]) -> Element {
        Element(name: name, closingMode: .selfClosing, nodes: attributes.asNodes())
    }
}

extension Element: Renderable {
    public func render(indentedBy indentation: Indentation?) -> String {
        let renderer = ElementRenderer(
            elementName: name,
            paddingCharacter: paddingCharacter,
            indentation: indentation
        )

        nodes.forEach { $0.render(into: renderer) }

        return renderer.render(withClosingMode: closingMode)
    }
}
