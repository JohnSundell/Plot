/**
*  Plot
*  Copyright (c) John Sundell 2021
*  MIT license, see LICENSE file for details
*/

import Foundation

/// Type used to define a group of components
///
/// The `members` contained within a `ComponentGroup` act as one
/// unit when passed around, with the exception that any modifier
/// that is applied to a group will be applied to each member
/// individually. So, for example, applying the `class` modifier
/// to a group results in each element within that group getting
/// that class name assigned to it.
public struct ComponentGroup: Component {
    /// The group's members. Will be rendered in order.
    public var members: [Component]
    public var body: Component { Node.components(members) }

    /// Create a new group with a given set of member components.
    /// - parameter members: The components that should be included
    ///   within the group. Will be rendered in order.
    public init(members: [Component]) {
        self.members = members
    }
}

extension ComponentGroup: ComponentContainer {
    public init(@ComponentBuilder content: () -> Self) {
        self = content()
    }
}

extension ComponentGroup: Sequence {
    public func makeIterator() -> Array<Component>.Iterator {
        members.makeIterator()
    }
}
