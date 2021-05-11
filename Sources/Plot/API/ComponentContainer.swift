/**
*  Plot
*  Copyright (c) John Sundell 2021
*  MIT license, see LICENSE file for details
*/

import Foundation

/// Protocol adopted by components that can act as a container for
/// other components. Plot ships with a number of implementations of
/// this protocol (such as `Div`, `List`, `Article`, and so on), and
/// you can easily create your own as well by implementing the required
/// initializer.
public protocol ComponentContainer: Component {
    /// Initialize this component with a closure that defines its content.
    /// - parameter content: The component content that should be contained
    ///   within this component.
    init(@ComponentBuilder content: @escaping ContentProvider)
}

public extension ComponentContainer {
    /// Initialize this component without any content.
    init() {
        self.init {}
    }

    /// Initialize this container with a single content component.
    /// - parameter component: The component to include as content.
    init(_ component: Component) {
        self.init { component }
    }

    /// Initialize this container with a string as its content.
    /// - parameter string: The text that this component should contain.
    ///   Any special characters that can't be rendered as-is will be escaped.
    init(_ string: String) {
        self.init { Node<Any>.text(string) }
    }

    /// Initialize this container with a raw HTML string.
    /// - parameter html: The HTML that this component should contain.
    ///   Won't be processed in any way, and will instead be rendered as-is.
    init(html: String) {
        self.init { Node<Any>.raw(html) }
    }
}
