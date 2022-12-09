/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Foundation

/// An enum that defines various values for an HTML anchor's `rel`
/// attribute, which specifies the relationship that the anchor has
/// to the URL that it's linking to.
public struct HTMLAnchorRelationship: RawRepresentable, Identifiable, ExpressibleByStringLiteral {
    public var id: String { rawValue }
    public var rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }
    
    // MARK: Default Values

    /// Provides a link to an alternate representation of the document (i.e. print page, translated or mirror)
    public static let alternate: HTMLAnchorRelationship = "alternate"

    /// Provides a link to the author of the document
    public static let author: HTMLAnchorRelationship = "author"

    /// Permanent URL used for bookmarking
    public static let bookmark: HTMLAnchorRelationship = "bookmark"

    /// Indicates that the referenced document is not part of the same site as the current document
    public static let external: HTMLAnchorRelationship = "external"

    /// Provides a link to a help document
    public static let help: HTMLAnchorRelationship = "help"

    /// Provides a link to licensing information for the document
    public static let license: HTMLAnchorRelationship = "license"

    /// Provides a link to the next document in the series
    public static let next: HTMLAnchorRelationship = "next"

    /// Links to an unendorsed document, like a paid link.
    /// - Note: "nofollow" is used by Google, to specify that the Google search spider should not follow that link
    public static let nofollow: HTMLAnchorRelationship = "nofollow"

    /// Requires that any browsing context created by following the hyperlink must not have an opener browsing context
    public static let noopener: HTMLAnchorRelationship = "noopener"

    /// Makes the referrer unknown. No referer header will be included when the user clicks the hyperlink
    public static let noreferrer: HTMLAnchorRelationship = "noreferrer"

    /// The previous document in a selection
    public static let prev: HTMLAnchorRelationship = "prev"

    /// Links to a search tool for the document
    public static let search: HTMLAnchorRelationship = "search"

    /// A tag (keyword) for the current document
    public static let tag: HTMLAnchorRelationship = "tag"

    /// For displaying augmented reality content in iOS Safari.
    /// Adding this tag will instruct Safari to directly open the content
    /// rather than navigating to a new page.
    /// https://webkit.org/blog/8421/viewing-augmented-reality-assets-in-safari-for-ios/
    public static let ar: HTMLAnchorRelationship = "ar"

    /// The opposite of `noopener`.
    public static let opener: HTMLAnchorRelationship = "opener"
}
