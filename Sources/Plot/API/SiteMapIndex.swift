/**
 *  Plot
 *  Copyright (c) John Sundell 2019
 *  MIT license, see LICENSE file for details
 */

import Foundation

/// A representation of a site map index, used by search engines when a
/// site map goes over the 50,000 entries or 50Mb maximum size. It is an
/// index of references to other site maps.
public struct SiteMapIndex: DocumentFormat {
    private let document: Document<SiteMapIndex>

    /// Create a site map index with a with a collection of site maps.
    /// - parameter nodes: All the `<sitemap>` elements in this site map index.
    public init(_ nodes: Node<SiteMapIndex.SiteMapIndexContext>...) {
        document = Document(elements: [
            .xml(.version(1.0), .encoding(.utf8)),
            .sitemapindex(.group(nodes))
        ])
    }
}

extension SiteMapIndex: NodeConvertible {
    public var node: Node<Self> { document.node }
}

public extension SiteMapIndex {
    /// The root context of a site map index document.
    enum RootContext: XMLRootContext {}
    /// The context within a `<sitemapindex>` element.
    enum SiteMapIndexContext {}
    /// The context within a `<sitemap>` element.
    enum SiteMapContext {}
}

internal extension SiteMapIndex {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
