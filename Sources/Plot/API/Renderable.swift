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
    /// Render this object into a string, optionally with a certain kind of indentation.
    /// - parameter indentationKind: What kind of indentation that should be used
    ///   when rendering. Passing `nil` will result in a minified, unindented output string.
    func render(indentedBy indentationKind: Indentation.Kind?) -> String
}

public extension Renderable {
    /// Render this object into a minified string, without any indentation.
    func render() -> String { render(indentedBy: nil) }
}
