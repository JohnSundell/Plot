/**
*  Plot
*  Copyright (c) John Sundell 2021
*  MIT license, see LICENSE file for details
*/

import Foundation

/// Type that represents a way to style `List` components.
///
/// Plot ships with two ready-made list styles, `ordered` (which
/// maps to the `<ol>` element), and `unordered` (which maps to
/// the `<ul>` element).
///
/// You can apply a list style to an entire component hierarchy
/// using the `listStyle` modifier, and you can access the current
/// style within a component using the `listStyle` environment key.
public struct HTMLListStyle {
    /// Closure type that's used to wrap an item within a `List` into
    /// a renderable component.
    public typealias ItemWrapper = (Component) -> Component

    /// The name of the element that should be used to render a list
    /// styled with this style.
    public var elementName: String
    /// A closure that's used to wrap each list item into a renderable
    /// component.
    public var itemWrapper: (Component) -> Component

    /// Create a new, custom list style.
    /// - parameter elementName: The name of the element that should be
    ///   used to render a list styled with this style.
    /// - parameter itemWrapper: A closure that wraps each item within a
    ///   styled list into a renderable component. Defaults to wrapping
    ///   each item into an `<li>` element, if needed.
    public init(
        elementName: String,
        itemWrapper: @escaping ItemWrapper = defaultItemWrapper
    ) {
        self.elementName = elementName
        self.itemWrapper = itemWrapper
    }
}

public extension HTMLListStyle {
    /// The default `ItemWrapper` closure that's used for all built-in `ListStyle`
    /// variants, and also acts as the default when creating custom ones. Wraps each
    /// item into an `<li>` element, if needed.
    static let defaultItemWrapper: ItemWrapper = { $0.wrappedInElement(named: "li") }
    /// List style that renders each `List` as unordered, using the `<ul>` element.
    static var unordered: Self { HTMLListStyle(elementName: "ul") }
    /// List style that renders each `List` as ordered, using the `<ol>` element.
    static var ordered: Self { HTMLListStyle(elementName: "ol") }

    /// Apply a certain class name to each item within lists styled by this style.
    /// - parameter className: The class name to apply. Will be applied to each
    ///   item after it's been wrapped using the `itemWrapper` closure.
    func withItemClass(_ className: String) -> Self {
        modifyingItems { $0.class(className) }
    }

    /// Use a closure to modify each item within lists styled by this style.
    /// - parameter modifier: The modifier closure to apply. Will recieve each
    ///   wrapped item (after it's been passed to the style's `itemWrapper`),
    ///   and is expected to return a new, transformed component.
    func modifyingItems(with modifier: @escaping (Component) -> Component) -> Self {
        var style = self
        style.itemWrapper = { modifier(itemWrapper($0)) }
        return style
    }
}
