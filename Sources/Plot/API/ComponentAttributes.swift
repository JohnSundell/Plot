/**
*  Plot
*  Copyright (c) John Sundell 2021
*  MIT license, see LICENSE file for details
*/

import Foundation

public extension Component {
    /// Assign an accessibility label to this component's element, which
    /// is used by assistive technologies to get a text representation of it.
    /// - parameter label: The label to assign.
    func accessibilityLabel(_ label: String) -> Component {
        attribute(named: "aria-label", value: label)
    }

    /// Assign a class name to this component's element. May also be a list
    /// of space-separated class names.
    /// - parameter className: The class or list of classes to assign.
    /// - parameter replaceExisting: Whether the new class name should replace
    ///   any existing one. Defaults to `false`, which will instead cause the
    ///   new class name to be appended to any existing one, separated by a space.
    func `class`(_ className: String, replaceExisting: Bool = false) -> Component {
        attribute(named: "class",
                  value: className,
                  replaceExisting: replaceExisting)
    }

    /// Add a `data-` attribute to this component's element.
    /// - parameter name: The name of the attribute to add. The name will be
    ///   prefixed with `data-`.
    /// - parameter value: The attribute's string value.
    func data(named name: String, value: String) -> Component {
        attribute(named: "data-" + name, value: value)
    }

    /// Assign an ID attribute to this component's element.
    /// - parameter id: The ID to assign.
    func id(_ id: String) -> Component {
        attribute(named: "id", value: id)
    }

    /// Assign whether this component hierarchy's `Input` components should have
    /// autocomplete turned on or off. This value is placed in the environment, and
    /// is thus inherited by all child components. Note that this modifier only
    /// affects components, not elements created using the `Node.input` API, or
    /// manually created input elements.
    /// - parameter isEnabled: Whether autocomplete should be enabled.
    func autoComplete(_ isEnabled: Bool) -> Component {
        environmentValue(isEnabled, key: .isAutoCompleteEnabled)
    }

    /// Assign a given `HTMLAnchorRelationship` to all `Link` components within
    /// this component hierarchy. Affects the `rel` attribute on the generated
    /// `<a>` elements. This value is placed in the environment, and is thus
    /// inherited by all child components. Note that this modifier only affects
    /// components, not elements created using the `Node.a` API, or manually
    /// created anchor elements.
    /// - parameter relationship: The relationship to assign.
    func linkRelationship(_ relationship: HTMLAnchorRelationship?) -> Component {
        environmentValue(relationship, key: .linkRelationship)
    }

    /// Assign a given `HTMLAnchorTarget` to all `Link` components within this
    /// component hierarchy. Affects the `target` attribute on the generated
    /// `<a>` elements. This value is placed in the environment, and is thus
    /// inherited by all child components. Note that this modifier only affects
    /// components, not elements created using the `Node.a` API, or manually
    /// created anchor elements.
    /// - parameter target: The target to assign.
    func linkTarget(_ target: HTMLAnchorTarget?) -> Component {
        environmentValue(target, key: .linkTarget)
    }

    /// Assign a given `HTMLListStyle` to all `List` components within this
    /// component hierarchy. You can use this modifier to decide whether lists
    /// should be rendered as ordered or unordered, or even use a completely
    /// custom style. This value is placed in the environment, and is thus
    /// inherited by all child components. Note that this modifier only affects
    /// components, not elements created using the `Node.ul` or `Node.ol` APIs,
    /// or manually created list elements.
    /// - parameter style: The style to assign.
    func listStyle(_ style: HTMLListStyle) -> Component {
        environmentValue(style, key: .listStyle)
    }

    /// Assign a given set of inline CSS styles to this component's element.
    /// - parameter css: A string containing the CSS code that should be assigned
    ///   to this component's `style` attribute.
    func style(_ css: String) -> Component {
        attribute(named: "style", value: css)
    }
}
