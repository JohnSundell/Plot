/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

public extension Node where Context == HTML.HeadContext {
    /// Declare that the HTML page is encoded using a certain encoding.
    /// - parameter encoding: The encoding to declare. See `DocumentEncoding`.
    static func encoding(_ encoding: DocumentEncoding) -> Node {
        .meta(.charset(encoding))
    }

    /// Link the HTML page to an external CSS stylesheet.
    /// - parameter url: The URL of the stylesheet to link to.
    /// - parameter integrity: optional base64-encoded cryptographic hash
    static func stylesheet(_ url: URLRepresentable, integrity: String? = nil) -> Node {
        .link(
            .rel(.stylesheet),
            .href(url.string),
            .type("text/css"),
            .unwrap(integrity, Attribute.integrity)
        )
    }

    /// Declare the HTML page's canonical URL, for social sharing and SEO.
    /// - parameter url: The URL to declare as this document's canonical URL.
    static func url(_ url: URLRepresentable) -> Node {
        let url = url.string

        return .group([
            .link(.rel(.canonical), .href(url)),
            .meta(.name("twitter:url"), .content(url)),
            .meta(.name("og:url"), .content(url))
        ])
    }

    /// Declare the name of the site that this HTML page belongs to.
    /// - parameter name: The name to declare.
    static func siteName(_ name: String) -> Node {
        .meta(.name("og:site_name"), .content(name))
    }

    /// Declare the HTML page's title, both for browsers and for social sharing.
    /// - parameter title: The title to declare.
    static func title(_ title: String) -> Node {
        .group([
            .element(named: "title", text: title),
            .meta(.name("twitter:title"), .content(title)),
            .meta(.name("og:title"), .content(title))
        ])
    }

    /// Declare a description of the HTML page, for social sharing and SEO.
    /// - parameter text: A text that describes the page's content.
    static func description(_ text: String) -> Node {
        .group([
            .meta(.name("description"), .content(text)),
            .meta(.name("twitter:description"), .content(text)),
            .meta(.name("og:description"), .content(text))
        ])
    }

    /// Declare a URL to an image that should be displayed when the HTML page
    /// is shared on a social media website or app.
    /// - parameter url: The URL to declare. Should be an absolute URL.
    static func socialImageLink(_ url: URLRepresentable) -> Node {
        let url = url.string

        return .group([
            .meta(.name("twitter:image"), .content(url)),
            .meta(.name("og:image"), .content(url))
        ])
    }

    /// Declare which card type that Twitter should use when displaying a link
    /// to this HTML page. See `TwitterCardType` for more details.
    /// - parameter type: The type of Twitter card to use for this page.
    static func twitterCardType(_ type: TwitterCardType) -> Node {
        .meta(.name("twitter:card"), .content(type.rawValue))
    }

    /// Declare how the page should behave in terms of viewport responsiveness.
    /// This declaration is important when building HTML pages for display on
    /// mobile devices, as it determines how the page's content will scale.
    /// - parameter widthMode: How the viewport's width should scale according
    ///   to the device the page is being rendered on. See `HTMLViewportWidthMode`.
    /// - parameter initialScale: The initial scale that the page should use.
    static func viewport(_ widthMode: HTMLViewportWidthMode,
                         initialScale: Double = 1) -> Node {
        let content = "width=\(widthMode.string), initial-scale=\(initialScale)"
        return .meta(.name("viewport"), .content(content))
    }

    /// Declare a "favicon" (a small icon typically displayed along the website's
    /// title in various browser UIs) for the HTML page.
    /// - parameter url: The favicon's URL.
    /// - parameter type: The MIME type of the image (default: "image/png").
    static func favicon(_ url: URLRepresentable, type: String = "image/png") -> Node {
        .link(.rel(.shortcutIcon), .href(url.string), .type(type))
    }

    /// Declare a url to an RSS feed to associate with this HTML page.
    /// - parameter url: The URL to the RSS feed.
    /// - parameter title: An optional title that some RSS readers will display
    ///   for the feed.
    static func rssFeedLink(_ url: URLRepresentable, title: String? = nil) -> Node {
        .link(
            .rel(.alternate),
            .href(url.string),
            .type("application/rss+xml"),
            .attribute(named: "title", value: title)
        )
    }
}
