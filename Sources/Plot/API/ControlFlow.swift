/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

public extension Node {
    /// Conditionally create a given node if a boolean expression is `true`,
    /// optionally falling back to another node using the `else` argument.
    /// - parameter condition: The boolean condition to evaluate.
    /// - parameter node: The node to add if the condition is `true`.
    /// - parameter fallbackNode: An optional node to fall back to in case
    ///   the condition is `false`.
    static func `if`(_ condition: Bool,
                     _ node: Node,
                     else fallbackNode: Node? = nil) -> Node {
        guard condition else {
            return fallbackNode ?? .empty
        }

        return node
    }

    /// Conditionally create a given node by unwrapping an optional, and then
    /// applying a transform to it. If the optional is `nil`, then no node will
    /// be created.
    /// - parameter optional: The optional value to unwrap.
    /// - parameter transform: The closure to use to transform the value into a node.
    /// - parameter fallbackNode: An optional node to fall back to in case
    ///   the passed `optional` is `nil`.
    static func unwrap<T>(_ optional: T?,
                          _ transform: (T) throws -> Node,
                          else fallbackNode: Node = .empty) rethrows -> Node {
        try optional.map(transform) ?? fallbackNode
    }

    /// Transform any sequence of values into a group of nodes, by applying a
    /// transform to each element.
    /// - parameter sequence: The sequence to transform.
    /// - parameter transform: The closure to use to transform each element into a node.
    static func forEach<S: Sequence>(_ sequence: S,
                                     _ transform: (S.Element) throws -> Node) rethrows -> Node {
        try .group(sequence.map(transform))
    }
}

public extension Attribute {
    /// Conditionally create a given attribute by unwrapping an optional, and then
    /// applying a transform to it. If the optional is `nil`, then no attribute will
    /// be created.
    /// - parameter optional: The optional value to unwrap.
    /// - parameter transform: The closure to use to transform the value into an attribute.
    /// - parameter fallbackAttribute: An optional attribute to fall back to in case
    ///   the passed `optional` is `nil`.
    static func unwrap<T>(_ optional: T?,
                          _ transform: (T) throws -> Self,
                          else fallbackAttribute: Self = .empty) rethrows -> Self {
        try optional.map(transform) ?? fallbackAttribute
    }
}
