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
    case noopener
    case noreferrer
    case opener
    case external
    /// For displaying augmented reality content in iOS Safari.
    /// Adding this tag will instruct Safari to directly open the content
    /// rather than navigating to a new page.
    /// https://webkit.org/blog/8421/viewing-augmented-reality-assets-in-safari-for-ios/
    case ar
}
