/**
*  Plot
*  Copyright (c) John Sundell 2021
*  MIT license, see LICENSE file for details
*/

import Foundation

/// Protocol used to make it possible to use a `Node`-based element with
/// the `ElementComponent` type. You typically don't have to conform to
/// this protocol yourself, unless you want to add first-class component
/// support for an HTML `Node` that Plot doesn't yet map to natively.
public protocol ElementDefinition {
    /// The context that the element's content nodes should all have.
    associatedtype InputContext
    /// The context that the element's own node should have.
    associatedtype OutputContext
    /// A closure that can be used to wrap a list of nodes into an element node.
    static var wrapper: (Node<InputContext>...) -> Node<OutputContext> { get }
}
