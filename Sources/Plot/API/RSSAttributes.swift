/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

public extension Node where Context: RSSFeedContext {
    /// Define the RSS version that this feed is using.
    /// - parameter version: The RSS version to use.
    static func version(_ version: Double) -> Node {
        .attribute(named: "version", value: String(version))
    }

    /// Add a namespace to this RSS feed.
    /// - parameter name: The name of the namespace to add.
    /// - parameter url: The URL of the namespace's definition.
    static func namespace(_ name: String, _ url: URLRepresentable) -> Node {
        .attribute(named: "xmlns:\(name)", value: url.string)
    }
}

public extension Node where Context == RSS.GUIDContext {
    /// Declare whether this GUID is a permalink or not.
    /// - parameter bool: Whether this GUID is a permalink to its item.
    static func isPermaLink(_ bool: Bool) -> Node {
        .attribute(named: "isPermaLink", value: String(bool))
    }
}
