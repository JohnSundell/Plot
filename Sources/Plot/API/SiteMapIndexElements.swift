/**
 *  Plot
 *  Copyright (c) John Sundell 2019
 *  MIT license, see LICENSE file for details
 */

import Foundation

// MARK: - Root

public extension Element where Context == SiteMapIndex.RootContext {
    /// Add a `<sitemapindex>` element within the root context.
    /// - parameter nodes: The element's attributes and child elements.
    static func sitemapindex(_ nodes: Node<SiteMapIndex.SiteMapIndexContext>...) -> Element {
        return Element(
            name: "sitemapindex",
            nodes: [ Attribute<SiteMapIndex.SiteMapIndexContext>(
                name: "xmlns",
                value: "http://www.sitemaps.org/schemas/sitemap/0.9"
            ).node ] + nodes
        )
    }
}

// MARK: - SiteMapIndex Context

public extension Node where Context == SiteMapIndex.SiteMapIndexContext {
    /// Add a `<sitemap>` element within a `<sitemapindex>`.
    /// - parameter nodes: The element's child elements.
    static func sitemap(_ nodes: Node<SiteMapIndex.SiteMapContext>...) -> Node {
        .element(named: "sitemap", nodes: nodes)
    }
}

// MARK: - SiteMap Context

public extension Node where Context == SiteMapIndex.SiteMapContext {
    /// Define the location of a site map with a `<loc>` element.
    /// - parameter url: The location of a site map in the index.
    static func loc(_ url: URLRepresentable) -> Node {
        .element(named: "loc", text: url.string)
    }

    /// Declare tha most recent modification date for any URLs in the linked site map.
    /// - parameter date: The most recent modification for any page in the linked site map.
    /// - parameter timeZone: The time zone of the given `Date` (default: `.current`).
    static func lastmod(_ date: Date, timeZone: TimeZone = .current) -> Node {
        let formatter = SiteMap.dateFormatter
        formatter.timeZone = timeZone
        let dateString = formatter.string(from: date)
        return .element(named: "lastmod", text: dateString)
    }
}
