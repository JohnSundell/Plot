/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import XCTest
import Plot

func assertEqualHTMLContent(
    _ document: HTML,
    _ content: String,
    file: StaticString = #file,
    line: UInt = #line
) {
    let html = document.render()
    let expectedPrefix = "<!DOCTYPE html><html>"
    let expectedSuffix = "</html>"

    XCTAssertTrue(
        html.hasPrefix(expectedPrefix),
        """
        Invalid HTML prefix.
        Expected '\(expectedPrefix)'.
        Found '\(html.prefix(expectedPrefix.count))'.
        """,
        file: file,
        line: line
    )

    XCTAssertTrue(
        html.hasSuffix(expectedSuffix),
        """
        Invalid HTML suffix.
        Expected '\(expectedSuffix)'.
        Found '\(html.suffix(expectedSuffix.count))'.
        """,
        file: file,
        line: line
    )

    let expectedContent = html
        .dropFirst(expectedPrefix.count)
        .dropLast(expectedSuffix.count)

    XCTAssertEqual(
        String(expectedContent),
        content,
        file: file,
        line: line
    )
}

func assertEqualSiteMapContent(
    _ document: SiteMap,
    _ content: String,
    file: StaticString = #file,
    line: UInt = #line
) {
    let map = document.render()

    let expectedPrefix = XML().render() + """
    <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" \
    xmlns:image="http://www.google.com/schemas/sitemap-image/1.1">
    """

    let expectedSuffix = "</urlset>"

    XCTAssertTrue(
        map.hasPrefix(expectedPrefix),
        """
        Invalid SiteMap prefix.
        Expected '\(expectedPrefix)'.
        Found '\(map.prefix(expectedPrefix.count))'.
        """,
        file: file,
        line: line
    )

    XCTAssertTrue(
        map.hasSuffix(expectedSuffix),
        """
        Invalid SiteMap suffix.
        Expected '\(expectedSuffix)'.
        Found '\(map.suffix(expectedSuffix.count))'.
        """,
        file: file,
        line: line
    )

    let expectedContent = map
        .dropFirst(expectedPrefix.count)
        .dropLast(expectedSuffix.count)

    XCTAssertEqual(
        String(expectedContent),
        content,
        file: file,
        line: line
    )
}

func assertEqualXMLContent(
    _ document: XML,
    _ content: String,
    file: StaticString = #file,
    line: UInt = #line
) {
    let xml = document.render()
    let declaration = #"<?xml version="1.0" encoding="UTF-8"?>"#

    XCTAssertTrue(
        xml.hasPrefix(declaration),
        """
        Invalid XML declaration.
        Expected '\(declaration)'.
        Found '\(xml.prefix(declaration.count))'.
        """,
        file: file,
        line: line
    )

    XCTAssertEqual(
        String(xml.dropFirst(declaration.count)),
        content,
        file: file,
        line: line
    )
}

func assertEqualPodcastFeedContent(
    _ feed: PodcastFeed,
    _ content: String,
    file: StaticString = #file,
    line: UInt = #line
) {
    assertEqualRSSFeedContent(
        feed,
        content,
        type: "podcast",
        namespaces: [
            ("atom", "http://www.w3.org/2005/Atom"),
            ("content", "http://purl.org/rss/1.0/modules/content/"),
            ("itunes", "http://www.itunes.com/dtds/podcast-1.0.dtd"),
            ("media", "http://www.rssboard.org/media-rss")
        ],
        file: file,
        line: line
    )
}

func assertEqualRSSFeedContent(
    _ feed: RSS,
    _ content: String,
    file: StaticString = #file,
    line: UInt = #line
) {
    assertEqualRSSFeedContent(
        feed,
        content,
        type: "RSS",
        namespaces: [
            ("atom", "http://www.w3.org/2005/Atom"),
            ("content", "http://purl.org/rss/1.0/modules/content/")
        ],
        file: file,
        line: line
    )
}

private func assertEqualRSSFeedContent<R: Renderable>(
    _ feed: R,
    _ content: String,
    type: String,
    namespaces: [(name: String, url: String)],
    file: StaticString,
    line: UInt
) {
    let xmlDeclaration = XML().render()

    let namespaces = namespaces.map({ name, url in
        "xmlns:\(name)=\"\(url)\""
    }).joined(separator: " ")

    let expectedPrefix = "\(xmlDeclaration)<rss version=\"2.0\" \(namespaces)><channel>"
    let expectedSuffix = "</channel></rss>"

    let xml = feed.render()

    XCTAssertTrue(
        xml.hasPrefix(expectedPrefix),
        """
        Invalid \(type) feed prefix.
        Expected '\(expectedPrefix)'.
        Found '\(xml.prefix(expectedPrefix.count))'.
        """,
        file: file,
        line: line
    )

    XCTAssertTrue(
        xml.hasSuffix(expectedSuffix),
        """
        \(type.capitalized) feed is not closed with '\(expectedSuffix)'.
        Feed: '\(xml)'
        """,
        file: file,
        line: line
    )

    let expectedContent = xml
        .dropFirst(expectedPrefix.count)
        .dropLast(expectedSuffix.count)

    XCTAssertEqual(
        String(expectedContent),
        content,
        file: file,
        line: line
    )
}
