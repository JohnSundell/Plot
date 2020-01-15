/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import XCTest
import Plot

final class HTMLTests: XCTestCase {
    func testEmptyHTML() {
        assertEqualHTMLContent(HTML(), "")
    }

    func testPageLanguage() {
        let html = HTML(.lang(.english))
        XCTAssertEqual(html.render(), #"<!DOCTYPE html><html lang="en"></html>"#)
    }

    func testHeadAndBody() {
        let html = HTML(.head(), .body())
        assertEqualHTMLContent(html, "<head></head><body></body>")
    }

    func testDocumentEncoding() {
        let html = HTML(.head(.encoding(.utf8)))
        assertEqualHTMLContent(html, #"<head><meta charset="UTF-8"/></head>"#)
    }

    func testCSSStylesheet() {
        let html = HTML(.head(.stylesheet("styles.css")))
        assertEqualHTMLContent(html, """
        <head><link rel="stylesheet" href="styles.css" type="text/css"/></head>
        """)
    }

    func testInlineCSS() {
        let html = HTML(
            .head(.style("body { color: #000; }")),
            .body(.style("color: #fff;"))
        )

        assertEqualHTMLContent(html, """
        <head><style>body { color: #000; }</style></head><body style="color: #fff;"></body>
        """)
    }

    func testSiteName() {
        let html = HTML(.head(.siteName("MySite")))
        assertEqualHTMLContent(html, """
        <head><meta name="og:site_name" content="MySite"/></head>
        """)
    }

    func testPageURL() {
        let html = HTML(.head(.url("url.com")))
        assertEqualHTMLContent(html, """
        <head>\
        <link rel="canonical" href="url.com"/>\
        <meta name="twitter:url" content="url.com"/>\
        <meta name="og:url" content="url.com"/>\
        </head>
        """)
    }

    func testPageTitle() {
        let html = HTML(.head(.title("Title")))
        assertEqualHTMLContent(html, """
        <head>\
        <title>Title</title>\
        <meta name="twitter:title" content="Title"/>\
        <meta name="og:title" content="Title"/>\
        </head>
        """)
    }

    func testPageDescription() {
        let html = HTML(.head(.description("Description")))
        assertEqualHTMLContent(html, """
        <head>\
        <meta name="description" content="Description"/>\
        <meta name="twitter:description" content="Description"/>\
        <meta name="og:description" content="Description"/>\
        </head>
        """)
    }

    func testSocialImageMetadata() {
        let html = HTML(.head(
            .socialImageLink("url.png"),
            .twitterCardType(.summaryLargeImage)
        ))

        assertEqualHTMLContent(html, """
        <head>\
        <meta name="twitter:image" content="url.png"/>\
        <meta name="og:image" content="url.png"/>\
        <meta name="twitter:card" content="summary_large_image"/>\
        </head>
        """)
    }

    func testResponsiveViewport() {
        let html = HTML(.head(.viewport(.accordingToDevice)))
        assertEqualHTMLContent(html, """
        <head><meta name="viewport" content="width=device-width, initial-scale=1.0"/></head>
        """)
    }

    func testStaticViewport() {
        let html = HTML(.head(.viewport(.constant(500))))
        assertEqualHTMLContent(html, """
        <head><meta name="viewport" content="width=500, initial-scale=1.0"/></head>
        """)
    }

    func testFavicon() {
        let html = HTML(.head(.favicon("icon.png")))
        assertEqualHTMLContent(html, """
        <head><link rel="shortcut icon" href="icon.png" type="image/png"/></head>
        """)
    }

    func testRSSFeedLink() {
        let html = HTML(.head(.rssFeedLink("feed.rss", title: "RSS")))
        assertEqualHTMLContent(html, """
        <head><link rel="alternate" href="feed.rss" type="application/rss+xml" title="RSS"/></head>
        """)
    }

    func testLinkWithHrefLang() {
        let html = HTML(.head(.link(
            .rel(.alternate),
            .href("http://site/"),
            .hreflang(.english)
        )))

        assertEqualHTMLContent(html, """
        <head><link rel="alternate" href="http://site/" hreflang="en"/></head>
        """)
    }

    func testAppleTouchIconLink() {
        let html = HTML(.head(.link(
            .rel(.appleTouchIcon),
            .sizes("180x180"),
            .href("apple-touch-icon.png")
        )))

        assertEqualHTMLContent(html, """
        <head><link rel="apple-touch-icon" sizes="180x180" href="apple-touch-icon.png"/></head>
        """)
    }

    func testManifestLink() {
        let html = HTML(.head(.link(
            .rel(.manifest),
            .href("site.webmanifest")
        )))

        assertEqualHTMLContent(html, """
        <head><link rel="manifest" href="site.webmanifest"/></head>
        """)
    }

    func testMaskIconLink() {
        let html = HTML(.head(.link(
            .rel(.maskIcon),
            .href("safari-pinned-tab.svg"),
            .color("#000000")
        )))

        assertEqualHTMLContent(html, """
        <head><link rel="mask-icon" href="safari-pinned-tab.svg" color="#000000"/></head>
        """)
    }

    func testBodyWithID() {
        let html = HTML(.body(.id("anID")))
        assertEqualHTMLContent(html, #"<body id="anID"></body>"#)
    }

    func testBodyWithCSSClass() {
        let html = HTML(.body(.class("myClass")))
        assertEqualHTMLContent(html, #"<body class="myClass"></body>"#)
    }

    func testOverridingBodyCSSClass() {
        let html = HTML(.body(.class("a"), .class("b")))
        assertEqualHTMLContent(html, #"<body class="b"></body>"#)
    }

    func testUnorderedList() {
        let html = HTML(.body(.ul(.li("Text"))))
        assertEqualHTMLContent(html, "<body><ul><li>Text</li></ul></body>")
    }

    func testOrderedList() {
        let html = HTML(.body(.ol(.li(.span("Text")))))
        assertEqualHTMLContent(html, "<body><ol><li><span>Text</span></li></ol></body>")
    }

    func testDescriptionList() {
        let html = HTML(.body(.dl(
            .dt("Term"),
            .dd("Description")
        )))

        assertEqualHTMLContent(html, """
        <body><dl><dt>Term</dt><dd>Description</dd></dl></body>
        """)
    }

    func testAnchors() throws {
        let html = try HTML(.body(
            .a(.href("a.html"), .target(.blank), .text("A")),
            .a(.href("b.html"), .rel(.nofollow), .text("B")),
            .a(.href(require(URL(string: "c.html"))), .text("C"))
        ))

        assertEqualHTMLContent(html, """
        <body>\
        <a href="a.html" target="_blank">A</a>\
        <a href="b.html" rel="nofollow">B</a>\
        <a href="c.html">C</a>\
        </body>
        """)
    }

    func testTable() {
        let html = HTML(.body(
            .table(
                .caption("Caption"),
                .tr(.th("Hello")),
                .tr(.td("World"))
            )
        ))

        assertEqualHTMLContent(html, """
        <body><table>\
        <caption>Caption</caption>\
        <tr><th>Hello</th></tr>\
        <tr><td>World</td></tr>\
        </table></body>
        """)
    }

    func testData() {
        let html = HTML(.body(
            .data(.value("123"), .text("Hello"))
        ))

        assertEqualHTMLContent(html, #"<body><data value="123">Hello</data></body>"#)
    }

    func testEmbeddedObject() {
        let html = HTML(.body(
            .embed(
                .src("url"),
                .type("some/type"),
                .width(500),
                .height(300)
            )
        ))

        assertEqualHTMLContent(html, #"""
        <body><embed src="url" type="some/type" width="500" height="300"/></body>
        """#)
    }

    func testForm() {
        let html = HTML(.body(
            .form(
                .action("url.com"),
                .fieldset(
                    .label(.for("a"), "A label"),
                    .input(.name("a"), .type(.text))
                ),
                .input(.name("b"), .type(.search), .autocomplete(false), .autofocus(true)),
                .input(.name("c"), .type(.text), .autofocus(false)),
                .input(.name("d"), .type(.email), .autocomplete(true), .required(true)),
                .textarea(.name("e"), .cols(50), .rows(10), .required(true), .text("Test")),
                .textarea(.name("f"), .autofocus(true)),
                .input(.type(.submit), .value("Send"))
            )
        ))

        assertEqualHTMLContent(html, """
        <body><form action="url.com">\
        <fieldset>\
        <label for="a">A label</label>\
        <input name="a" type="text"/>\
        </fieldset>\
        <input name="b" type="search" autocomplete="off" autofocus="true"/>\
        <input name="c" type="text"/>\
        <input name="d" type="email" autocomplete="on" required="true"/>\
        <textarea name="e" cols="50" rows="10" required="true">Test</textarea>\
        <textarea name="f" autofocus="true"></textarea>\
        <input type="submit" value="Send"/>\
        </form></body>
        """)
    }
    
    func testFormContentType() {
        let html = HTML(.body(
            .form(.enctype(.urlEncoded)),
            .form(.enctype(.multipartData)),
            .form(.enctype(.plainText))
        ))
        
        assertEqualHTMLContent(html, """
        <body>\
        <form enctype="application/x-www-form-urlencoded"></form>\
        <form enctype="multipart/form-data"></form>\
        <form enctype="text/plain"></form>\
        </body>
        """)
    }
    
    func testFormMethod() {
        let html = HTML(.body(
            .form(.method(.get)),
            .form(.method(.post))
        ))

        assertEqualHTMLContent(html, """
        <body>\
        <form method="get"></form>\
        <form method="post"></form>\
        </body>
        """)
    }
    
    func testHeadings() {
        let html = HTML(.body(
            .h1("One"),
            .h2("Two"),
            .h3("Three"),
            .h4("Four"),
            .h5("Five"),
            .h6("Six")
        ))

        assertEqualHTMLContent(html, """
        <body>\
        <h1>One</h1>\
        <h2>Two</h2>\
        <h3>Three</h3>\
        <h4>Four</h4>\
        <h5>Five</h5>\
        <h6>Six</h6>\
        </body>
        """)
    }

    func testParagraph() {
        let html = HTML(.body(.p("Text")))
        assertEqualHTMLContent(html, "<body><p>Text</p></body>")
    }

    func testImage() {
        let html = HTML(.body(
            .img(
                .id("id"),
                .class("image"),
                .src("image.png"),
                .alt("Text")
            )
        ))

        assertEqualHTMLContent(html, """
        <body><img id="id" class="image" src="image.png" alt="Text"/></body>
        """)
    }

    func testAudioPlayer() {
        let html = HTML(.body(
            .audio(.source(.src("a.mp3"), .type(.mp3))),
            .audio(.controls(true), .source(.src("b.wav"), .type(.wav))),
            .audio(.controls(false), .source(.src("c.ogg"), .type(.ogg)))
        ))

        assertEqualHTMLContent(html, """
        <body>\
        <audio><source src="a.mp3" type="audio/mpeg"/></audio>\
        <audio controls><source src="b.wav" type="audio/wav"/></audio>\
        <audio><source src="c.ogg" type="audio/ogg"/></audio>\
        </body>
        """)
    }

    func testVideoPlayer() {
        let html = HTML(.body(
            .video(.source(.src("a.mp4"), .type(.mp4))),
            .video(.controls(true), .source(.src("b.webm"), .type(.webM))),
            .video(.controls(false), .source(.src("c.ogg"), .type(.ogg)))
        ))

        assertEqualHTMLContent(html, """
        <body>\
        <video><source src="a.mp4" type="video/mp4"/></video>\
        <video controls><source src="b.webm" type="video/webm"/></video>\
        <video><source src="c.ogg" type="video/ogg"/></video>\
        </body>
        """)
    }

    func testArticle() {
        let html = HTML(.body(
            .article(
                .header(.h1("Title")),
                .p("Body"),
                .footer(.span("Footer"))
            )
        ))

        assertEqualHTMLContent(html, """
        <body><article>\
        <header><h1>Title</h1></header>\
        <p>Body</p>\
        <footer><span>Footer</span></footer>\
        </article></body>
        """)
    }

    func testCode() {
        let html = HTML(.body(
            .p(.code("hello()")),
            .pre(.code("world()"))
        ))

        assertEqualHTMLContent(html, """
        <body>\
        <p><code>hello()</code></p>\
        <pre><code>world()</code></pre>\
        </body>
        """)
    }

    func testTextStyling() {
        let html = HTML(.body(
            .b("Bold"),
            .strong("Bold"),
            .i("Italic"),
            .em("Italic"),
            .u("Underlined"),
            .s("Strikethrough"),
            .ins("Inserted"),
            .del("Deleted")
        ))

        assertEqualHTMLContent(html, """
        <body>\
        <b>Bold</b>\
        <strong>Bold</strong>\
        <i>Italic</i>\
        <em>Italic</em>\
        <u>Underlined</u>\
        <s>Strikethrough</s>\
        <ins>Inserted</ins>\
        <del>Deleted</del>\
        </body>
        """)
    }

    func testIFrame() {
        let html = HTML(.body(
            .iframe(
                .src("url.com"),
                .frameborder(false),
                .allow("gyroscope"),
                .allowfullscreen(true)
            )
        ))

        assertEqualHTMLContent(html, """
        <body>\
        <iframe src="url.com" frameborder="0" allow="gyroscope" allowfullscreen="true"></iframe>\
        </body>
        """)
    }

    func testJavaScript() {
        let html = HTML(
            .head(.script(.src("file.js"))),
            .body(.script(#"console.log("Consider going JS-free :)")"#))
        )

        assertEqualHTMLContent(html, """
        <head><script src="file.js"></script></head>\
        <body><script>console.log("Consider going JS-free :)")</script></body>
        """)
    }

    func testButton() {
        let html = HTML(.body(
            .button(.name("Name"), .value("Value"), .text("Text"))
        ))

        assertEqualHTMLContent(html, """
        <body><button name="Name" value="Value">Text</button></body>
        """)
    }

    func testAbbreviation() {
        let html = HTML(.body(
            .abbr(.title("HyperText Markup Language"), "HTML")
        ))

        assertEqualHTMLContent(html, """
        <body><abbr title="HyperText Markup Language">HTML</abbr></body>
        """)
    }

    func testBlockquote() {
        let html = HTML(.body(.blockquote("Quote")))
        assertEqualHTMLContent(html, "<body><blockquote>Quote</blockquote></body>")
    }

    func testListsOfOptions() {
        let html = HTML(.body(
            .datalist(
                .option(.value("A")),
                .option(.value("B"))
            ),
            .select(
                .option(.value("C"), .isSelected(true)),
                .option(.value("D"), .isSelected(false))
            )
        ))

        assertEqualHTMLContent(html, """
        <body>\
        <datalist><option value="A"/><option value="B"/></datalist>\
        <select><option value="C" selected/><option value="D"/></select>\
        </body>
        """)
    }

    func testDetails() {
        let html = HTML(.body(
            .details(.summary("Summary"), .p("Text"))
        ))

        assertEqualHTMLContent(html, """
        <body><details><summary>Summary</summary><p>Text</p></details></body>
        """)
    }

    func testLineBreak() {
        let html = HTML(.body("One", .br(), "Two"))
        assertEqualHTMLContent(html, "<body>One<br/>Two</body>")
    }

    func testHorizontalLine() {
        let html = HTML(.body("One", .hr(), "Two"))
        assertEqualHTMLContent(html, "<body>One<hr/>Two</body>")
    }

    func testNoScript() {
        let html = HTML(.body(.noscript("NoScript")))
        assertEqualHTMLContent(html, "<body><noscript>NoScript</noscript></body>")
    }

    func testNavigation() {
        let html = HTML(.body(.nav("Navigation")))
        assertEqualHTMLContent(html, "<body><nav>Navigation</nav></body>")
    }

    func testSection() {
        let html = HTML(.body(.section("Section")))
        assertEqualHTMLContent(html, "<body><section>Section</section></body>")
    }

    func testMain() {
        let html = HTML(.body(.main("Main")))
        assertEqualHTMLContent(html, "<body><main>Main</main></body>")
    }

    func testAccessibilityLabel() {
        let html = HTML(.body(.button(.text("X"), .ariaLabel("Close"))))
        assertEqualHTMLContent(html, #"<body><button aria-label="Close">X</button></body>"#)
    }
    
    func testAccessibilityControls() {
        let html = HTML(.body(.ul(.li(.id("list"), .ariaControls("div"))), .div(.id("div"))))
        assertEqualHTMLContent(html, """
        <body>\
        <ul><li id="list" aria-controls="div"></li></ul><div id="div"></div>\
        </body>
        """)
    }
    
    func testAccessibilityExpanded() {
        let html = HTML(.body(.a(.ariaExpanded(true))))
        assertEqualHTMLContent(html, #"<body><a aria-expanded="true"></a></body>"#)
    }

    func testDataAttributes() {
        let html = HTML(.body(
            .data(named: "user-name", value: "John"),
            .img(.data(named: "icon", value: "User"))
        ))

        assertEqualHTMLContent(html, """
        <body data-user-name="John"><img data-icon="User"/></body>
        """)
    }
    
    func testSubresourceIntegrity() {
        let html = HTML(.head(
            .script(.src("file.js"), .integrity("sha384-fakeHash")),
            .link(.rel(.stylesheet), .href("styles.css"), .type("text/css"), .integrity("sha512-fakeHash")),
            .stylesheet("styles2.css", integrity: "sha256-fakeHash")
        ))

        assertEqualHTMLContent(html, """
        <head><script src="file.js" integrity="sha384-fakeHash"></script>\
        <link rel="stylesheet" href="styles.css" type="text/css" integrity="sha512-fakeHash"/>\
        <link rel="stylesheet" href="styles2.css" type="text/css" integrity="sha256-fakeHash"/>\
        </head>
        """)
    }

    func testComments() {
        let html = HTML(.comment("Hello"), .body(.comment("World")))
        assertEqualHTMLContent(html, "<!--Hello--><body><!--World--></body>")
    }
}

extension HTMLTests {
    static var allTests: Linux.TestList<HTMLTests> {
        [
            ("testEmptyHTML", testEmptyHTML),
            ("testPageLanguage", testPageLanguage),
            ("testHeadAndBody", testHeadAndBody),
            ("testDocumentEncoding", testDocumentEncoding),
            ("testCSSStylesheet", testCSSStylesheet),
            ("testInlineCSS", testInlineCSS),
            ("testSiteName", testSiteName),
            ("testPageURL", testPageURL),
            ("testPageTitle", testPageTitle),
            ("testPageDescription", testPageDescription),
            ("testSocialImageMetadata", testSocialImageMetadata),
            ("testResponsiveViewport", testResponsiveViewport),
            ("testStaticViewport", testStaticViewport),
            ("testFavicon", testFavicon),
            ("testRSSFeedLink", testRSSFeedLink),
            ("testLinkWithHrefLang", testLinkWithHrefLang),
            ("testAppleTouchIconLink", testAppleTouchIconLink),
            ("testManifestLink", testManifestLink),
            ("testMaskIconLink", testMaskIconLink),
            ("testBodyWithID", testBodyWithID),
            ("testBodyWithCSSClass", testBodyWithCSSClass),
            ("testOverridingBodyCSSClass", testOverridingBodyCSSClass),
            ("testUnorderedList", testUnorderedList),
            ("testOrderedList", testOrderedList),
            ("testDescriptionList", testDescriptionList),
            ("testAnchors", testAnchors),
            ("testTable", testTable),
            ("testData", testData),
            ("testEmbeddedObject", testEmbeddedObject),
            ("testForm", testForm),
            ("testFormContentType", testFormContentType),
            ("testFormMethod", testFormMethod),
            ("testHeadings", testHeadings),
            ("testParagraph", testParagraph),
            ("testImage", testImage),
            ("testAudioPlayer", testAudioPlayer),
            ("testVideoPlayer", testVideoPlayer),
            ("testArticle", testArticle),
            ("testCode", testCode),
            ("testTextStyling", testTextStyling),
            ("testIFrame", testIFrame),
            ("testJavaScript", testJavaScript),
            ("testButton", testButton),
            ("testAbbreviation", testAbbreviation),
            ("testBlockquote", testBlockquote),
            ("testListsOfOptions", testListsOfOptions),
            ("testDetails", testDetails),
            ("testLineBreak", testLineBreak),
            ("testHorizontalLine", testHorizontalLine),
            ("testNoScript", testNoScript),
            ("testNavigation", testNavigation),
            ("testSection", testSection),
            ("testMain", testMain),
            ("testAccessibilityLabel", testAccessibilityLabel),
            ("testAccessibilityControls", testAccessibilityControls),
            ("testAccessibilityExpanded", testAccessibilityExpanded),
            ("testDataAttributes", testDataAttributes),
            ("testSubresourceIntegrity", testSubresourceIntegrity),
            ("testComments", testComments)
        ]
    }
}
