/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Foundation

/// Protocol adopted by types that can represent a URL, which
/// can then be converted into a string using the `description`
/// property. `URL` and `String` conforms to this protocol.
public protocol URLRepresentable: CustomStringConvertible {}

extension URL: URLRepresentable {}
extension String: URLRepresentable {}

internal extension URLRepresentable {
    var string: String { description }
}
