/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Foundation

/// A representation of an element attribute, for example an HTML element's
/// `id` or `class`. You normally don't construct `Attribute` values manually,
/// but rather use Plot's various DSL APIs to create them, for example by using
/// the `id()` or `class()` modifier on an HTML element.
public struct Attribute<Context> {
    public enum EmptyValueRenderingBehaviour {
        /// Attribute is completely ignored
        case ignore
        /// Only the name of attribute is rendered
        case renderJustName
        /// Attribute is rendered with empty value
        case renderEmptyValue
    }
    /// The name of the attribute
    public var name: String
    /// The attribute's value
    public var value: String?
    /// Defines how attribute is rendered if it's value is empty
    public var ifValueIsEmpty: EmptyValueRenderingBehaviour

    /// Create a new `Attribute` instance with a name and a value, and optionally
    /// opt out of ignoring the attribute if its value is empty.
    public init(name: String,
                value: String?,
                ifValueIsEmpty: EmptyValueRenderingBehaviour = .ignore) {
        self.name = name
        self.value = value
        self.ifValueIsEmpty = ifValueIsEmpty
    }
}

public extension Attribute {
    /// Create a completely empty attribute, that's ignored during rendering.
    /// This is useful in contexts where you need to return an `Attribute`, but
    /// your logic determines that nothing should be added.
    static var empty: Attribute {
        Attribute(name: "", value: nil)
    }

    /// Create an attribute with a given name and value. This is the recommended
    /// way of creating completely custom attributes, or ones that Plot does not
    /// yet support, when within an attribute context.
    static func attribute(named name: String, value: String?) -> Self {
        Attribute(name: name, value: value)
    }
}

internal extension Attribute where Context == Any {
    static func any(name: String, value: String) -> Attribute {
        Attribute(name: name, value: value)
    }
}

internal protocol AnyAttribute {
    var name: String { get }
    func render() -> String
}

extension Attribute: AnyAttribute {
    func render() -> String {
        guard let value = value, !value.isEmpty else {
            switch ifValueIsEmpty {
            case .ignore:
                return ""
            case .renderJustName:
                return name
            case .renderEmptyValue:
                return #"\#(name)="""#
            }
        }

        return "\(name)=\"\(value)\""
    }
}

extension Attribute: NodeConvertible {
    func asNode() -> AnyNode {
        Node<Context>.attribute(self)
    }
}
