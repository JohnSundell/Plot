/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

public extension Attribute where Context == PodcastFeed.EnclosureContext {
    /// Assign an URL from which the enclosure's file can be downloaded.
    /// - parameter url: The URL to assign.
    static func url(_ url: URLRepresentable) -> Attribute {
        Attribute(name: "url", value: url.string)
    }

    /// Assign a length to the enclosure, in terms of its file size.
    /// - parameter byteCount: The file's size in bytes.
    static func length(_ byteCount: Int) -> Attribute {
        Attribute(name: "length", value: String(byteCount))
    }

    /// Assign a MIME type to the enclosure.
    /// - parameter mimeType: The MIME type to assign.
    static func type(_ mimeType: String) -> Attribute {
        Attribute(name: "type", value: mimeType)
    }
}
