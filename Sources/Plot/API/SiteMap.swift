/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Foundation

/// A representation of a site map, a special XML format used by search
/// engines to index web sites. Create an instance of this type to build
/// a site map using Plot's type-safe DSL, and then call the `render()`
/// method to turn it into an XML string.
public struct SiteMap: DocumentFormat {
    private let document: Document<SiteMap>

    /// Create a site map with a collection of nodes that make up its
    /// elements and attributes. Use the `.url()` API to create a new
    /// URL definition within the site map.
    /// - parameter nodes: The root nodes of the document, which will
    /// be placed inside of a `<urlset>` element.
    public init(_ nodes: Node<SiteMap.URLSetContext>...) {
        document = Document(elements: [
            .xml(.version(1.0), .encoding(.utf8)),
            .urlset(.group(nodes))
        ])
    }
}

extension SiteMap: NodeConvertible {
    public var node: Node<Self> { document.node }
}

public extension SiteMap {
    /// The root context of a site map. Plot automatically creates
    /// all required elements within this context for you.
    enum RootContext: XMLRootContext {}
    /// The context within a site map's `<urlset>` element.
    enum URLSetContext {}
    /// The context within a site map's `<url>` element.
    enum URLContext {}
}

internal extension SiteMap {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
