/**
*  Plot
*  Copyright (c) John Sundell 2021
*  MIT license, see LICENSE file for details
*/

import Foundation

/// Protocol adopted by types that can be converted into renderable nodes.
///
/// You typically don't conform to this protocol yourself within your own code.
/// Instead, Plot will automatically convert the elements, components and
/// attributes that you create using its DSL into nodes that are then rendered.
public protocol NodeConvertible: Renderable {
    /// The context of the node that this type can be converted into.
    associatedtype Context
    /// Convert this instance into a renderable node. See `Node` for more info.
    var node: Node<Context> { get }
}

public extension NodeConvertible {
    func render(indentedBy indentationKind: Indentation.Kind?) -> String {
        Renderer.render(node, indentedBy: indentationKind)
    }
}

extension Array: Renderable, NodeConvertible where Element: NodeConvertible {
    public var node: Node<Element.Context> { .group(map(\.node)) }
}
