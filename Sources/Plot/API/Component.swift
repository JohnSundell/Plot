/**
*  Plot
*  Copyright (c) John Sundell 2021
*  MIT license, see LICENSE file for details
*/

import Foundation

/// Protocol used to define components that can be rendered into HTML.
///
/// Implement custom types conforming to this protocol to create your own
/// HTML components that can then be rendered using either the built-in
/// component types that Plot ships with, or using the `Node`-based API.
///
/// You can freely mix and match components and nodes when implementing
/// a component, and any component can be converted into a `Node`, either
/// by creating a `.component` node, or by calling `convertToNode()`
/// on a component.
///
/// Modifiers can be applied to components to change attributes like `class`
/// and `id`, and using the `EnvironmentValue` property wrapper and the
/// `EnvironmentKey` type, you can propagate environmental values through
/// a hierarchy of nodes and components.
public protocol Component: Renderable {
    /// The underlying component that should be used to render this component.
    /// Can either be a `Node`, another `Component`, or a group of components
    /// created using the `ComponentGroup` type.
    var body: Component { get }
}

public extension Component {
    /// A convenience type alias for a closure that creates the contents of a
    /// given component. Closures of this type are typically marked with the
    /// `@ComponentBuilder` attribute to enable Plot's DSL to be used when
    /// implementing them.
    typealias ContentProvider = () -> ComponentGroup

    /// Add an attribute to the HTML element used to render this component.
    /// - parameter name: The name of the attribute to add.
    /// - parameter value: The value that the attribute should have.
    /// - parameter replaceExisting: Whether any existing attribute with the
    ///   same name should be replaced by the new attribute. Defaults to `true`,
    ///   and if set to `false`, this attribute's value will instead be appended
    ///   to any existing one, separated by a space.
    /// - parameter ignoreValueIfEmpty: Whether the attribute should be ignored if
    ///   its value is `nil` or empty. Defaults to `true`, and if set to `false`,
    ///   only the attribute's name will be rendered if its value is empty.
    func attribute(named name: String,
                   value: String?,
                   replaceExisting: Bool = true,
                   ignoreValueIfEmpty: Bool = true) -> Component {
        attribute(Attribute<Any>(
            name: name,
            value: value,
            replaceExisting: replaceExisting,
            ignoreIfValueIsEmpty: ignoreValueIfEmpty
        ))
    }

    /// Add an attribute to the HTML element used to render this component.
    /// - parameter attribute: The attribute to add. See the documentation for
    ///   the `Attribute` type for more information.
    func attribute<T>(_ attribute: Attribute<T>) -> Component {
        if let group = self as? ComponentGroup {
            return ComponentGroup(members: group.members.map {
                $0.attribute(attribute)
            })
        }

        if var modified = self as? ModifiedComponent {
            modified.deferredAttributes.append(attribute)
            return modified
        }

        return ModifiedComponent(
            base: self,
            deferredAttributes: [attribute]
        )
    }

    /// Place a value into the environment used to render this component and any
    /// of its child components. An environment value will be passed downwards
    /// through a component/node hierarchy until its overridden by another value
    /// for the same key.
    /// - parameter value: The value to add. Must match the type of the key that
    ///   it's being added for. This value will override any value that was assigned
    ///   by a parent component for the same key, or the key's default value.
    /// - parameter key: The key to associate the value with. You can either use any
    ///   of the built-in key definitions that Plot ships with, or define your own.
    ///   See `EnvironmentKey` for more information.
    func environmentValue<T>(_ value: T, key: EnvironmentKey<T>) -> Component {
        let override = Environment.Override(key: key, value: value)

        if var modified = self as? ModifiedComponent {
            modified.environmentOverrides.append(override)
            return modified
        }

        return ModifiedComponent(
            base: self,
            environmentOverrides: [override]
        )
    }

    /// Convert this component into a `Node`, with either an inferred or explicit
    /// context. Use this API when you want to embed a component into a `Node`-based
    /// hierarchy. Calling this method is equivalent to creating a `.component` node
    /// using this component.
    /// - parameter context: The context of the returned node (can typically be
    ///   inferred by the compiler based on the call site).
    func convertToNode<T>(withContext context: T.Type = T.self) -> Node<T> {
        .component(self)
    }

    func render(indentedBy indentationKind: Indentation.Kind?) -> String {
        var renderer = Renderer(indentationKind: indentationKind)
        renderer.renderComponent(self)
        return renderer.result
    }
}

internal extension Component {
    func wrappedInElement(named wrappingElementName: String) -> Component {
        wrapped(using: ElementWrapper(
            wrappingElementName: wrappingElementName
        ))
    }

    func wrapped(using wrapper: ElementWrapper) -> Component {
        guard !(self is EmptyComponent) else {
            return self
        }

        if let group = self as? ComponentGroup {
            return ComponentGroup(
                members: group.members.map {
                    $0.wrapped(using: wrapper)
                }
            )
        }

        return Node.wrappingComponent(self, using: wrapper)
    }
}
