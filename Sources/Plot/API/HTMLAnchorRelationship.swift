/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Foundation

/// An enum that defines various values for an HTML anchor's `rel`
/// attribute, which specifies the relationship that the anchor has
/// to the URL that it's linking to.
public enum HTMLAnchorRelationship: String {
    /// Instructs bots, indexers and parsers that the link should
    /// not be followed when parsing the current page.
    case nofollow
}
