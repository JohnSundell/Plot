/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Foundation

/// Enum defining various ways that the width of an HTML page's
/// viewport can scale across different screen sizes.
public enum HTMLViewportWidthMode {
    /// The viewport should scale according to the user's device.
    case accordingToDevice
    /// The viewport should remain constant, at a given number
    /// of pixels (or points, for retina screens).
    case constant(Int)
}

internal extension HTMLViewportWidthMode {
    var string: String {
        switch self {
        case .accordingToDevice:
            return "device-width"
        case .constant(let width):
            return String(width)
        }
    }
}
