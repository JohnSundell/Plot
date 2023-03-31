/**
*  Plot
*  Copyright (c) John Sundell 2021
*  MIT license, see LICENSE file for details
*/

import Foundation

/// Result builder used to combine all of the `Component` expressions that appear
/// within a given attributed scope into a single `ComponentGroup`.
///
/// You can annotate any function or closure with the `@ComponentBuilder` attribute
/// to have its contents be processed by this builder. Note that you never have to
/// call any of the methods defined within this type directly. Instead, the Swift
/// compiler will automatically map your expressions to calls into this builder type.
@resultBuilder public enum ComponentBuilder {
    /// Build a `ComponentGroup` from a list of components.
    /// - parameter components: The components that should be included in the group.
    public static func buildBlock(_ components: Component...) -> ComponentGroup {
        ComponentGroup(members: components)
    }

    /// Build a flattened `ComponentGroup` from an array of component groups.
    /// - parameter groups: The component groups to flatten into a single group.
    public static func buildArray(_ groups: [ComponentGroup]) -> ComponentGroup {
        ComponentGroup(members: groups.flatMap { $0 })
    }

    /// Pick the first `ComponentGroup` within a conditional statement.
    /// - parameter component: The component to pick.
    public static func buildEither(first component: ComponentGroup) -> ComponentGroup {
        component
    }

    /// Pick the second `ComponentGroup` within a conditional statement.
    /// - parameter component: The component to pick.
    public static func buildEither(second component: ComponentGroup) -> ComponentGroup {
        component
    }

    /// Build a `ComponentGroup` from an optional group.
    /// - parameter component: The optional to transform into a concrete group.
    public static func buildOptional(_ component: ComponentGroup?) -> ComponentGroup {
        component ?? ComponentGroup(members: [])
    }
}
