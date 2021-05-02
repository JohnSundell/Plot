/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Foundation

/// A representation of a podcast feed. Create an instance of this
/// type to build a feed using Plot's type-safe DSL, and then call
/// the `render()` method to turn it into an RSS string.
public struct PodcastFeed: RSSBasedDocumentFormat {
    private let document: Document<PodcastFeed>

    /// Create a podcast feed with a collection of nodes that make
    /// up the items (episodes) in the feed. Each item can be created
    /// using the `.item()` API.
    /// - parameter nodes: The nodes that make up the podcast's
    ///   episodes. Will be placed within a `<channel>` element.
    public init(_ nodes: Node<ChannelContext>...) {
        document = .feed(
            .namespace("itunes", "http://www.itunes.com/dtds/podcast-1.0.dtd"),
            .namespace("media", "http://www.rssboard.org/media-rss"),
            .channel(.group(nodes))
        )
    }
}

extension PodcastFeed: NodeConvertible {
    public var node: Node<Self> { document.node }
}

public extension PodcastFeed {
    /// The root context of a podcast feed. Plot automatically creates
    /// all required elements within this context for you.
    enum RootContext: RSSRootContext {}
    /// The context within the top level of a podcast feed, within the
    /// `<rss>` element. Plot automatically creates all required elements
    /// within this context for you.
    enum FeedContext: RSSFeedContext {
        public typealias ChannelContext = PodcastFeed.ChannelContext
    }
    /// The context within a podcast's `<channel>` element, in which
    /// episodes can be defined.
    enum ChannelContext: RSSChannelContext, PodcastContentContext, PodcastCategoryContext {
        public typealias ItemContext = PodcastFeed.ItemContext
    }
    /// The context within a podcast's `<itunes:category>` element.
    enum CategoryContext: PodcastCategoryContext {}
    /// The context within a podcast episode's `<enclosure>` element.
    enum EnclosureContext {}
    /// The context within a podcast episode's `<item>` element.
    enum ItemContext: PodcastContentContext, RSSItemContext {}
    /// The context within a podcast episode's `<media_content>` element.
    enum MediaContext {}
    /// The context within a podcast's `<itunes:owner>` element.
    enum OwnerContext: PodcastNameableContext {}
}

/// Context shared among all elements that define podcast categories.
public protocol PodcastCategoryContext: PodcastNameableContext {}
/// Context shared among all elements that define podcast content.
public protocol PodcastContentContext: RSSContentContext {}
/// Context shared among all elements that define podcast names.
public protocol PodcastNameableContext {}
