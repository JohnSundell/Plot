/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import XCTest
import Plot

final class RSSTests: XCTestCase {
    func testEmptyFeed() {
        let feed = RSS()
        assertEqualRSSFeedContent(feed, "")
    }

    func testFeedTitle() {
        let feed = RSS(.title("MyPodcast"))
        assertEqualRSSFeedContent(feed, "<title>MyPodcast</title>")
    }

    func testFeedDescription() {
        let feed = RSS(.description("Description"))
        assertEqualRSSFeedContent(feed, "<description>Description</description>")
    }

    func testFeedDescriptionWithHTMLContent() {
        let feed = RSS(
            .description(
                .p(
                    .text("Description with "),
                    .em("emphasis"),
                    .text(".")
                )
            )
        )
        assertEqualRSSFeedContent(feed, "<description><![CDATA[<p>Description with <em>emphasis</em>.</p>]]></description>")
    }

    func testFeedURL() {
        let feed = RSS(.link("url.com"))
        assertEqualRSSFeedContent(feed, "<link>url.com</link>")
    }

    func testFeedAtomLink() {
        let feed = RSS(.atomLink("url.com"))
        assertEqualRSSFeedContent(feed, """
        <atom:link href="url.com" rel="self" type="application/rss+xml"/>
        """)
    }

    func testFeedLanguage() {
        let feed = RSS(.language(.usEnglish))
        assertEqualRSSFeedContent(feed, "<language>en-us</language>")
    }

    func testFeedTTL() {
        let feed = RSS(.ttl(200))
        assertEqualRSSFeedContent(feed, "<ttl>200</ttl>")
    }

    func testFeedPublicationDate() throws {
        let stubs = try Date.makeStubs(withFormattingStyle: .rss)
        let feed = RSS(.pubDate(stubs.date, timeZone: stubs.timeZone))
        assertEqualRSSFeedContent(feed, "<pubDate>\(stubs.expectedString)</pubDate>")
    }

    func testFeedLastBuildDate() throws {
        let stubs = try Date.makeStubs(withFormattingStyle: .rss)
        let feed = RSS(.lastBuildDate(stubs.date, timeZone: stubs.timeZone))
        assertEqualRSSFeedContent(feed, "<lastBuildDate>\(stubs.expectedString)</lastBuildDate>")
    }

    func testItemGUID() {
        let feed = RSS(
            .item(.guid("123")),
            .item(.guid("url.com", .isPermaLink(true))),
            .item(.guid("123", .isPermaLink(false)))
        )

        assertEqualRSSFeedContent(feed, """
        <item><guid>123</guid></item>\
        <item><guid isPermaLink="true">url.com</guid></item>\
        <item><guid isPermaLink="false">123</guid></item>
        """)
    }

    func testItemTitle() {
        let feed = RSS(.item(.title("Title")))
        assertEqualRSSFeedContent(feed, "<item><title>Title</title></item>")
    }

    func testItemDescription() {
        let feed = RSS(.item(.description("Description")))
        assertEqualRSSFeedContent(feed, """
        <item><description>Description</description></item>
        """)
    }

    func testItemURL() {
        let feed = RSS(.item(.link("url.com")))
        assertEqualRSSFeedContent(feed, "<item><link>url.com</link></item>")
    }

    func testItemPublicationDate() throws {
        let stubs = try Date.makeStubs(withFormattingStyle: .rss)
        let feed = RSS(.item(.pubDate(stubs.date, timeZone: stubs.timeZone)))
        assertEqualRSSFeedContent(feed, """
        <item><pubDate>\(stubs.expectedString)</pubDate></item>
        """)
    }

    func testItemHTMLStringContent() {
        let feed = RSS(.item(.content(
            "<p>Hello</p><p>World &amp; Everyone!</p>"
        )))

        assertEqualRSSFeedContent(feed, """
        <item>\
        <content:encoded>\
        <![CDATA[<p>Hello</p><p>World &amp; Everyone!</p>]]>\
        </content:encoded>\
        </item>
        """)
    }

    func testItemHTMLDSLContent() {
        let feed = RSS(.item(
            .content(.h1("Title"))
        ))

        assertEqualRSSFeedContent(feed, """
        <item>\
        <content:encoded>\
        <![CDATA[<h1>Title</h1>]]>\
        </content:encoded>\
        </item>
        """)
    }
}
