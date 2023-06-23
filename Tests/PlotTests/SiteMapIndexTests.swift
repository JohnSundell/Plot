/**
 *  Plot
 *  Copyright (c) John Sundell 2019
 *  MIT license, see LICENSE file for details
 */

import XCTest
import Plot

final class SiteMapIndexTests: XCTestCase {
    func testEmptySiteMapIndex() {
        let map = SiteMapIndex()

        XCTAssertEqual(map.render(indentedBy: .spaces(4)), """
        <?xml version="1.0" encoding="UTF-8"?>
        <sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"></sitemapindex>
        """)
    }

    func testSiteMapIndex() {
        let map = SiteMapIndex(
            .sitemap(
                .loc("https://example.com/sitemap-one.xml")
            ),
            .sitemap(
                .loc("https://example.com/sitemap-two.xml")
            )
        )

        XCTAssertEqual(map.render(indentedBy: .spaces(4)), """
        <?xml version="1.0" encoding="UTF-8"?>
        <sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
            <sitemap>
                <loc>https://example.com/sitemap-one.xml</loc>
            </sitemap>
            <sitemap>
                <loc>https://example.com/sitemap-two.xml</loc>
            </sitemap>
        </sitemapindex>
        """)
    }

    func testSiteMapIndexWithLastModifiedDate() throws {
        let dateStubs = try Date.makeStubs(withFormattingStyle: .siteMap)

        let map = SiteMapIndex(
            .sitemap(
                .loc("https://example.com/sitemap-one.xml")
            ),
            .sitemap(
                .loc("https://example.com/sitemap-two.xml"),
                .lastmod(dateStubs.date)
            )
        )

        XCTAssertEqual(map.render(indentedBy: .spaces(4)), """
        <?xml version="1.0" encoding="UTF-8"?>
        <sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
            <sitemap>
                <loc>https://example.com/sitemap-one.xml</loc>
            </sitemap>
            <sitemap>
                <loc>https://example.com/sitemap-two.xml</loc>
                <lastmod>2019-10-17</lastmod>
            </sitemap>
        </sitemapindex>
        """)
    }
}
