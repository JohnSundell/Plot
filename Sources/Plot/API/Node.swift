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
public struct Node<Context> {
    private let rendering: (inout Renderer) -> Void
}

public extension Node {
    /// An empty node, which won't be rendered.
    static var empty: Node { Node { _ in } }

    /// Create a node from a raw piece of text that should be rendered as-is.
    /// - parameter text: The raw text that the node should contain.
    static func raw(_ text: String) -> Node {
        Node { $0.renderRawText(text) }
    }

    /// Create a node from a piece of free-form text that should be escaped.
    /// - parameter text: The text that the node should contain.
    static func text(_ text: String) -> Node {
        Node { $0.renderText(text) }
    }

    /// Create a node representing an element
    /// - parameter element: The element that the node should contain.
    static func element(_ element: Element<Context>) -> Node {
        Node { $0.renderElement(element) }
    }

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
        .element(Element(name: name, nodes: attributes.map(\.node)))
    }

    /// Create a custom element with a given name and an array of attributes.
    /// - parameter name: The name of the element to create.
    /// - parameter attributes: The attributes to add to the element.
    static func element(named name: String, attributes: [Attribute<Context>]) -> Node {
        .element(Element(name: name, nodes: attributes.map(\.node)))
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
        .element(Element(name: name, closingMode: .selfClosing, nodes: attributes.map(\.node)))
    }

    /// Create a custom self-closed element with a given name and an array of attributes.
    /// - parameter name: The name of the element to create.
    /// - parameter attributes: The attributes to add to the element.
    static func selfClosedElement(named name: String, attributes: [Attribute<Context>]) -> Node {
        .element(Element(name: name, closingMode: .selfClosing, nodes: attributes.map(\.node)))
    }

    /// Create a node that represents an attribute.
    /// - parameter attribute: The attribute that the node should contain.
    static func attribute(_ attribute: Attribute<Context>) -> Node {
        Node { $0.renderAttribute(attribute) }
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

    /// Create a group of nodes from an array.
    /// - parameter members: The nodes that should be included in the group.
    static func group(_ members: [Node]) -> Node {
        Node { renderer in
            members.forEach { $0.render(into: &renderer) }
        }
    }

    /// Create a group of nodes using variadic parameter syntax.
    /// - parameter members: The nodes that should be included in the group.
    static func group(_ members: Node...) -> Node {
        .group(members)
    }

    /// Create a node that wraps a `Component`. You can use this API to
    /// integrate a component into a `Node`-based hierarchy.
    /// - parameter component: The component that should be wrapped.
    static func component(_ component: Component) -> Node {
        Node { $0.renderComponent(component) }
    }

    /// Create a node that wraps a set of components defined within a closure. You
    /// can use this API to integrate a group of components into a `Node`-based hierarchy.
    /// - parameter content: A closure that creates a group of components.
    static func components(@ComponentBuilder _ content: () -> Component) -> Node {
        .component(content())
    }
}

internal extension Node where Context: DocumentFormat {
    static func document(_ document: Document<Context>) -> Node {
        Node { renderer in
            document.elements.forEach {
                renderer.renderElement($0)
            }
        }
    }
}

internal extension Node where Context == Any {
    static func modifiedComponent(_ component: ModifiedComponent) -> Node {
        Node { renderer in
            renderer.renderComponent(component.base,
                deferredAttributes: component.deferredAttributes + renderer.deferredAttributes,
                environmentOverrides: component.environmentOverrides
            )
        }
    }

    static func components(_ components: [Component]) -> Node {
        Node { renderer in
            components.forEach {
                renderer.renderComponent($0,
                    deferredAttributes: renderer.deferredAttributes
                )
            }
        }
    }

    static func wrappingComponent(
        _ component: Component,
        using wrapper: ElementWrapper
    ) -> Node {
        Node { renderer in
            var wrapper = wrapper
            wrapper.deferredAttributes = renderer.deferredAttributes

            renderer.renderComponent(component,
                elementWrapper: wrapper
            )
        }
    }
}

extension Node: NodeConvertible {
    public var node: Self { self }

    public func render(indentedBy indentationKind: Indentation.Kind?) -> String {
        Renderer.render(self, indentedBy: indentationKind)
    }
}

extension Node: Component {
    public var body: Component { self }
}

extension Node: ExpressibleByStringInterpolation {
    public init(stringLiteral value: String) {
        self = .text(value)
    }
}

extension Node: AnyNode {
    func render(into renderer: inout Renderer) {
        rendering(&renderer)
    }
}
