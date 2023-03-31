/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

// MARK: - Channel

public extension Node where Context == PodcastFeed.ChannelContext {
    /// Instruct Apple Podcasts that the podcast's feed has moved to a new URL.
    /// - parameter url: The feed's new URL.
    static func newFeedURL(_ url: URLRepresentable) -> Node {
        .element(named: "itunes:new-feed-url", text: url.string)
    }

    /// Attach a copyright notice to the feed.
    /// - parameter text: The copyright text to attach.
    static func copyright(_ text: String) -> Node {
        .element(named: "copyright", text: text)
    }

    /// Define the podcast's owner.
    /// - parameter nodes: The element's child nodes.
    static func owner(_ nodes: Node<PodcastFeed.OwnerContext>...) -> Node {
        .element(named: "itunes:owner", nodes: nodes)
    }

    /// Declare the podcast's type.
    /// - parameter type: The type to declare. See `PodcastType` for more info.
    static func type(_ type: PodcastType) -> Node {
        .element(named: "itunes:type", text: type.rawValue)
    }
}

// MARK: - Any content context

public extension Node where Context: PodcastContentContext {
    /// Declare who is the author of the content.
    /// - parameter name: The name of the author.
    static func author(_ name: String) -> Node {
        .element(named: "itunes:author", text: name)
    }

    /// Define a subtitle for the content.
    /// - parameter text: The content's subtitle.
    static func subtitle(_ text: String) -> Node {
        .element(named: "itunes:subtitle", text: text)
    }

    /// Define a summary text for the content.
    /// - parameter text: The content's summary text.
    static func summary(_ text: String) -> Node {
        .element(named: "itunes:summary", text: text)
    }

    /// Declare whether the content is explicit.
    ///
    /// See Apple Podcast's guidelines as to what kind of content is
    /// considered explicit, and should be marked with this flag.
    ///
    /// - parameter isExplicit: Whether the content is explicit.
    static func explicit(_ isExplicit: Bool) -> Node {
        .element(named: "itunes:explicit",
                 text: isExplicit ? "yes" : "no")
    }

    /// Associate an image with the content.
    /// - parameter url: The URL of the content's image.
    static func image(_ url: URLRepresentable) -> Node {
        .selfClosedElement(
            named: "itunes:image",
            attributes: [.any(name: "href", value: url.string)]
        )
    }
}

// MARK: - Owner

public extension Node where Context == PodcastFeed.OwnerContext {
    /// Define the owner's name.
    /// - parameter name: The owner's name.
    static func name(_ name: String) -> Node {
        .element(named: "itunes:name", text: name)
    }

    /// Define the owner's email address.
    /// - parameter email: The owner's email address.
    static func email(_ email: String) -> Node {
        .element(named: "itunes:email", text: email)
    }
}

// MARK: - Categories

public extension Node where Context: PodcastCategoryContext {
    /// Define the category that the podcast belongs to.
    /// - parameter name: The name of the category.
    /// - parameter subcategory: Any optional, more specific subcategory.
    static func category(_ name: String, _ subcategory: Node<PodcastFeed.CategoryContext> = .empty) -> Node {
        .element(Element(name: "itunes:category", closingMode: .selfClosing, nodes: [
            .attribute(named: "text", value: name),
            subcategory
        ]))
    }
}

// MARK: - Items (episodes)

public extension Node where Context == PodcastFeed.ItemContext {
    /// Define the episode's title.
    /// - parameter title: The title to define.
    static func title(_ title: String) -> Node {
        .group(
            .element(named: "title", text: title),
            .element(named: "itunes:title", text: title)
        )
    }

    /// Define the duration of the episode as a string.
    ///
    /// Consider using the more type-safe `hours:minutes:seconds:` variant
    /// if you're defining a duration in code.
    ///
    /// - parameter string: A string that describes the episode's duration.
    ///   Should be specified in the HH:mm:ss format.
    static func duration(_ string: String) -> Node {
        .element(named: "itunes:duration", text: string)
    }

    /// Define the duration of the episode.
    /// - parameter hours: The number of hours.
    /// - parameter minutes: The number of minutes.
    /// - parameter seconds: The number of seconds.
    static func duration(hours: Int, minutes: Int, seconds: Int) -> Node {
        func wrap(_ number: Int) -> String {
            number < 10 ? "0\(number)" : String(number)
        }

        return .duration("\(wrap(hours)):\(wrap(minutes)):\(wrap(seconds))")
    }

    /// Define which season that the episode belongs to.
    /// - parameter number: The number of the episode's season.
    static func seasonNumber(_ number: Int) -> Node {
        .element(named: "itunes:season", text: String(number))
    }

    /// Define the episode's number.
    /// - parameter number: The episode number.
    static func episodeNumber(_ number: Int) -> Node {
        .element(named: "itunes:episode", text: String(number))
    }

    /// Define the episode's type.
    /// - parameter type: The type of the episode. See `PodcastEpisodeType`.
    static func episodeType(_ type: PodcastEpisodeType) -> Node {
        .element(named: "itunes:episodeType", text: type.rawValue)
    }

    /// Define an enclosure for the episode's media files.
    /// - parameter attributes: The element's attributes.
    static func enclosure(_ attributes: Attribute<PodcastFeed.EnclosureContext>...) -> Node {
        .selfClosedElement(named: "enclosure", attributes: attributes)
    }

    /// Define the episode's media content metadata.
    /// - parameter nodes: The element's child elements and attributes.
    static func mediaContent(_ nodes: Node<PodcastFeed.MediaContext>...) -> Node {
        .element(named: "media:content", nodes: nodes)
    }
}

// MARK: - Media

public extension Node where Context == PodcastFeed.MediaContext {
    /// Assign an URL from which the media's file can be downloaded.
    /// - parameter url: The URL to assign.
    static func url(_ url: URLRepresentable) -> Node {
        .attribute(named: "url", value: url.string)
    }

    /// Assign a length to the media item, in terms of its file size.
    /// - parameter byteCount: The file's size in bytes.
    static func length(_ byteCount: Int) -> Node {
        .attribute(named: "length", value: String(byteCount))
    }

    /// Assign a MIME type to the media item.
    /// - parameter mimeType: The MIME type to assign.
    static func type(_ mimeType: String) -> Node {
        .attribute(named: "type", value: mimeType)
    }

    /// Define whether the media item is the default one for this episode.
    /// - parameter isDefault: Whether this is the default media item.
    static func isDefault(_ isDefault: Bool) -> Node {
        .attribute(named: "isDefault", value: String(isDefault))
    }

    /// Define the type of this media item.
    /// - parameter type: The type of the item. See `PodcastMediaType`.
    static func medium(_ type: PodcastMediaType) -> Node {
        .attribute(named: "medium", value: type.rawValue)
    }

    /// Define the media item's title (usually the episode's title).
    /// - Parameter title: The title to define.
    static func title(_ title: String) -> Node {
        .element(named: "media:title", nodes: [
            .attribute(named: "type", value: "plain"),
            Node.text(title)
        ])
    }
}
