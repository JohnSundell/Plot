/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Foundation

/// Protocol adopted by all types that can be rendered into a string.
///
/// You never have to conform to this protocol yourself, instead Plot
/// ships with multiple types that use this protocol, for example `Node`,
/// `Element` and `Document`.
public protocol Renderable {
    /// The type of indentation that the value can be rendered using.
    associatedtype IndentationType
    /// Render this object into a string with a given type of indentation.
    /// - parameter indentation: How to indent the rendered string.
    func render(indentedBy indentation: IndentationType?) -> String
}

public extension Renderable {
    /// Render this object into a minified string, without any indentation.
    func render() -> String { render(indentedBy: nil) }
}

extension Array: Renderable where Element: Renderable {
    public func render(indentedBy indentation: Element.IndentationType?) -> String {
        reduce(into: "") { string, node in
            string.append(node.render(indentedBy: indentation))
        }
    }
}
