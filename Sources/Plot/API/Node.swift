/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Foundation

/// A representation of a node within a document's hierarchy.
///
/// Plot treats all elements and attributes that a document contains
/// as nodes. When using the Plot DSL, each time you create a new
/// element, or add an attribute to an existing one, you are creating
/// a node. Nodes can also contain just text, which can either be
/// escaped or treated as raw, pre-processed text. Groups can also be
/// created to form components.
public enum Node<Context> {
    /// An element, which can potentially have children.
    case element(Element<Context>)
    /// An attribute attached to an element.
    case attribute(Attribute<Context>)
    /// A piece of free-form text that should be escaped.
    case text(String)
    /// A piece of raw text that will be rendered as-is.
    case raw(String)
    /// A group of nodes that should be rendered in sequence.
    case group([Node])
    /// An empty node, which won't be rendered.
    case empty
}

public extension Node {
    /// Create a custom element with a given name.
    /// - parameter name: The name of the element to create.
    static func element(named name: String) -> Node {
        .element(Element(name: name, nodes: []))
    }

    /// Create a custom element with a given name and an array of child nodes.
    /// - parameter name: The name of the element to create.
    /// - parameter nodes: The nodes (child elements + attributes) to add to the element.
    static func element(named name: String, nodes: [Node]) -> Node {
        .element(Element(name: name, nodes: nodes))
    }

    /// Create a custom element with a given name and an array of child nodes.
    /// - parameter name: The name of the element to create.
    /// - parameter nodes: The nodes (child elements + attributes) to add to the element.
    static func element<C>(named name: String, nodes: [Node<C>]) -> Node {
        .element(Element(name: name, nodes: nodes))
    }

    /// Create a custom element with a given name and text content.
    /// - parameter name: The name of the element to create.
    /// - parameter text: The text to use as the node's content.
    static func element(named name: String, text: String) -> Node {
        .element(Element(name: name, nodes: [Node.text(text)]))
    }

    /// Create a custom element with a given name and an array of attributes.
    /// - parameter name: The name of the element to create.
    /// - parameter attributes: The attributes to add to the element.
    static func element<C>(named name: String, attributes: [Attribute<C>]) -> Node {
        .element(Element(name: name, nodes: attributes.asNodes()))
    }

    /// Create a custom element with a given name and an array of attributes.
    /// - parameter name: The name of the element to create.
    /// - parameter attributes: The attributes to add to the element.
    static func element(named name: String, attributes: [Attribute<Context>]) -> Node {
        .element(Element(name: name, nodes: attributes.asNodes()))
    }

    /// Create a custom self-closed element with a given name.
    /// - parameter name: The name of the element to create.
    static func selfClosedElement(named name: String) -> Node {
        .element(Element(name: name, closingMode: .selfClosing, nodes: []))
    }

    /// Create a custom self-closed element with a given name and an array of attributes.
    /// - parameter name: The name of the element to create.
    /// - parameter attributes: The attributes to add to the element.
    static func selfClosedElement<C>(named name: String, attributes: [Attribute<C>]) -> Node {
        .element(Element(name: name, closingMode: .selfClosing, nodes: attributes.asNodes()))
    }

    /// Create a custom self-closed element with a given name and an array of attributes.
    /// - parameter name: The name of the element to create.
    /// - parameter attributes: The attributes to add to the element.
    static func selfClosedElement(named name: String, attributes: [Attribute<Context>]) -> Node {
        .element(Element(name: name, closingMode: .selfClosing, nodes: attributes.asNodes()))
    }

    /// Create a custom attribute with a given name.
    /// - parameter name: The name of the attribute to create.
    static func attribute(named name: String) -> Node {
        .attribute(Attribute(
            name: name,
            value: nil,
            ignoreIfValueIsEmpty: false
        ))
    }

    /// Create a custom attribute with a given name and value.
    /// - parameter name: The name of the attribute to create.
    /// - parameter value: The attribute's value.
    /// - parameter ignoreIfValueIsEmpty: Whether the attribute should be ignored if
    ///   its value is empty (default: true).
    static func attribute(named name: String,
                          value: String?,
                          ignoreIfValueIsEmpty: Bool = true) -> Node {
        .attribute(Attribute(
            name: name,
            value: value,
            ignoreIfValueIsEmpty: ignoreIfValueIsEmpty
        ))
    }

    /// Create a group of nodes using variadic parameter syntax.
    /// - parameter members: The nodes that should be included in the group.
    static func group(_ members: Node...) -> Node {
        .group(members)
    }
}

extension Node: Renderable {
    public func render(indentedBy indentationKind: Indentation.Kind?) -> String {
        switch self {
        case .element(let element):
            let indentation = indentationKind.map(Indentation.init)
            return element.render(indentedBy: indentation)
        case .attribute(let attribute):
            return attribute.render()
        case .text(let text):
            return text.escaped()
        case .raw(let text):
            return text
        case .group(let nodes):
            return nodes.render(indentedBy: indentationKind)
        case .empty:
            return ""
        }
    }
}

extension Node: ExpressibleByStringInterpolation {
    public init(stringLiteral value: String) {
        self = .text(value)
    }
}
