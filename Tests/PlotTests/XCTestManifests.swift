/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import XCTest

public func allTests() -> [Linux.TestCase] {
    return [
        Linux.makeTestCase(using: ControlFlowTests.allTests),
        Linux.makeTestCase(using: DocumentTests.allTests),
        Linux.makeTestCase(using: HTMLTests.allTests),
        Linux.makeTestCase(using: IndentationTests.allTests),
        Linux.makeTestCase(using: NodeTests.allTests),
        Linux.makeTestCase(using: PodcastFeedTests.allTests),
        Linux.makeTestCase(using: RSSTests.allTests),
        Linux.makeTestCase(using: SiteMapTests.allTests),
        Linux.makeTestCase(using: XMLTests.allTests)
    ]
}
