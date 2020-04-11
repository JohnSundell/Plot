/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Foundation

/// Enum defining the fit parameters of the viewport meta tag.
public enum HTMLViewportFitMode: String {
    /// This value doesn’t affect the initial layout viewport, and the whole web page is viewable.
    /// What the UA paints outside of the viewport is undefined.
    /// It may be the background color of the canvas, or anything else that the UA deems appropriate.
    case auto
    /// The initial layout viewport and the visual viewport are set to the largest rectangle which is
    /// inscribed in the display of the device. What the UA paints outside of the viewport is undefined.
    /// It may be the background color of the canvas, or anything else that the UA deems appropriate.
    case contain
    /// The initial layout viewport and the visual viewport
    /// are set to the circumscribed rectangle of the physical screen of the device.
    case cover
}
