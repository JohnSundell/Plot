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
    /// The name of the attribute
    public var name: String
    /// The attribute's value
    public var value: String?
    /// Whether the attribute's value should replace any existing one that has
    /// already been added to a given element for the same attribute name.
    public var replaceExisting: Bool
    /// Whether the attribute should be completely ignored if it has no value.
    public var ignoreIfValueIsEmpty: Bool

    /// Create a new `Attribute` instance with a name and a value, and optionally
    /// opt out of ignoring the attribute if its value is empty, and decide whether the
    /// attribute should replace any existing one that's already been added to an element
    /// for the same name.
    public init(name: String,
                value: String?,
                replaceExisting: Bool = true,
                ignoreIfValueIsEmpty: Bool = true) {
        self.name = name
        self.value = value
        self.replaceExisting = replaceExisting
        self.ignoreIfValueIsEmpty = ignoreIfValueIsEmpty
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

extension Attribute: NodeConvertible {
    public var node: Node<Context> { .attribute(self) }
}

extension Attribute: AnyAttribute {
    func render() -> String {
        guard let value = nonEmptyValue else {
            return ignoreIfValueIsEmpty ? "" : name
        }

        return "\(name)=\"\(value)\""
    }
}
