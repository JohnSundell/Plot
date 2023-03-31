/**
*  Plot
*  Copyright (c) John Sundell 2021
*  MIT license, see LICENSE file for details
*/

import Foundation

/// A type that represents an empty, non-rendered component. It's typically
/// used within contexts where some kind of `Component` needs to be returned,
/// but when you don't actually want to render anything. Modifiers have no
/// affect on this component.
public struct EmptyComponent: Component {
    /// Initialize an empty component.
    public init() {}
    public var body: Component { Node<Any>.empty }
}
