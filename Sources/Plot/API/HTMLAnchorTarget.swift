/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Foundation

/// An enum that defines various values for an HTML anchor's `target`
/// attribute, which specifies how its URL should be opened.
public enum HTMLAnchorTarget: String {
    /// The URL should be opened in the current browser context (default).
    case current = "self"
    /// The URL should be opened in a new, blank tab or window.
    case blank = "_blank"
    /// The URL should be opened in any parent frame.
    case parent = "_parent"
    /// The URL should be opened in the topmost frame.
    case top = "_top"
}

extension HTMLAnchorTarget {
    @available(*, deprecated, message: "Use .current instead")
    static var `self`: Self { current }
}
