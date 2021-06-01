/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Foundation

/// Enum defining the fit parameters of the viewport meta tag.
public enum HTMLViewportFitMode: String {
    /// The default viewport fit behavior.
    case auto
    /// The initial layout viewport and the visual viewport are set
    /// to fit within the safe area insets of the screen of the device.
    case contain
    /// The initial layout viewport and the visual viewport are set
    /// to the outer rectangle covering the screen, ignoring safe area insets.
    case cover
}
