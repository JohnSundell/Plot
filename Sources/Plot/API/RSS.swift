/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Foundation

/// Protocol adopted by all document formats that are based on RSS.
public protocol RSSBasedDocumentFormat: DocumentFormat where RootContext: RSSRootContext {
    /// The context of the document's feed
    associatedtype FeedContext: RSSFeedContext
}

/// A representation of an RSS feed. Create an instance of this type
/// to build an RSS feed using Plot's type-safe DSL, and then call the
/// `render()` method to turn it into an RSS string.
public struct RSS: RSSBasedDocumentFormat {
    private let document: Document<RSS>

    /// Create an RSS feed with a collection of nodes that make up the
    /// items in the feed. Each item can be created using the `.item()`
    /// API.
    /// - parameter nodes: The nodes that make up the feed's items.
    ///   Will be placed within a `<channel>` element.
    public init(_ nodes: Node<ChannelContext>...) {
        document = .feed(.channel(.group(nodes)))
    }
}

extension RSS: NodeConvertible {
    public var node: Node<Self> { document.node }
}

public extension RSS {
    /// The root context of an RSS feed. Plot automatically creates
    /// all required elements within this context for you.
    enum RootContext: RSSRootContext {}
    /// The context within the top level of a podcast feed, within the
    /// `<rss>` element. Plot automatically creates all required elements
    /// within this context for you.
    enum FeedContext: RSSFeedContext {
        public typealias ChannelContext = RSS.ChannelContext
    }
    /// The context within a feed's `<channel>` element, in which
    /// items can be defined.
    enum ChannelContext: RSSChannelContext, RSSContentContext {
        public typealias ItemContext = RSS.ItemContext
    }
    /// The context within an RSS feed's `<item>` elements.
    enum ItemContext: RSSItemContext {}
    /// The context within an RSS item's `<guid>` element.
    enum GUIDContext {}
}

/// Protocol adopted by all contexts that are at the root level of
/// an RSS-based document format.
public protocol RSSRootContext: XMLRootContext {}
/// Protocol adopted by all contexts that define an RSS feed.
public protocol RSSFeedContext {
    /// The feed's channel context.
    associatedtype ChannelContext: RSSChannelContext
}
/// Protocol adopted by all contexts that define an RSS channel.
public protocol RSSChannelContext {
    /// The channel's item context.
    associatedtype ItemContext: RSSItemContext
}
/// Protocol adopted by all contexts that define RSS-based content.
public protocol RSSContentContext {}
/// Protocol adopted by all contexts that define an RSS item.
public protocol RSSItemContext: RSSContentContext {}

internal extension RSS {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}

internal extension Document where Format: RSSBasedDocumentFormat {
    static func feed(_ nodes: Node<Format.FeedContext>...) -> Document {
        Document(elements: [
            .xml(.version(1.0), .encoding(.utf8)),
            .rss(
                .version(2.0),
                .namespace("atom", "http://www.w3.org/2005/Atom"),
                .namespace("content", "http://purl.org/rss/1.0/modules/content/"),
                .group(nodes)
            )
        ])
    }
}
