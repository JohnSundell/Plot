<p align="center">
    <img src="Logo.png" width="400" max-width="90%" alt="Plot" />
</p>

<p align="center">
    <img src="https://img.shields.io/badge/Swift-5.4-orange.svg" />
    <a href="https://swift.org/package-manager">
        <img src="https://img.shields.io/badge/swiftpm-compatible-brightgreen.svg?style=flat" alt="Swift Package Manager" />
    </a>
     <img src="https://img.shields.io/badge/platforms-mac+linux-brightgreen.svg?style=flat" alt="Mac + Linux" />
    <a href="https://twitter.com/johnsundell">
        <img src="https://img.shields.io/badge/twitter-@johnsundell-blue.svg?style=flat" alt="Twitter: @johnsundell" />
    </a>
</p>

Welcome to **Plot**, a domain-specific language (DSL) for writing type-safe HTML, XML and RSS in Swift. It can be used to build websites, documents and feeds, as a templating tool, or as a renderer for higher-level components and tools. It’s primary focus is on static site generation and Swift-based web development.

Plot is used to build and render all of [swiftbysundell.com](https://swiftbysundell.com).

## Write HTML — in Swift!

Plot enables you to write HTML using native, fully compiled Swift code, by modeling the HTML5 standard’s various elements as Swift APIs. The result is a very lightweight DSL that lets you build complete web pages in a highly expressive way:

```swift
let html = HTML(
    .head(
        .title("My website"),
        .stylesheet("styles.css")
    ),
    .body(
        .div(
            .h1("My website"),
            .p("Writing HTML in Swift is pretty great!")
        )
    )
)
```

Looking at the above, it may at first seem like Plot simply maps each function call directly to an equivalent HTML element — and while that’s the case for *some* elements, Plot also inserts many kinds of highly valuable metadata automatically. For example, the above expression will result in this HTML:

```html
<!DOCTYPE html>
<html>
    <head>
        <title>My website</title>
        <meta name="twitter:title" content="My website"/>
        <meta name="og:title" content="My website"/>
        <link rel="stylesheet" href="styles.css" type="text/css"/>
    </head>
    <body>
        <div>
            <h1>My website</h1>
            <p>Writing HTML in Swift is pretty great!</p>
        </div>
    </body>
</html>
```

As you can see above, Plot added both all of the necessary attributes to load the requested CSS stylesheet, along with additional metadata for the page’s title as well — improving page rendering, social media sharing, and search engine optimization.

Plot ships with a very wide coverage of the HTML5 standard, enabling all sorts of elements to be defined using the same lightweight syntax — such as tables, lists, and inline text styling:

```swift
let html = HTML(
    .body(
        .h2("Countries and their capitals"),
        .table(
            .tr(.th("Country"), .th("Capital")),
            .tr(.td("Sweden"), .td("Stockholm")),
            .tr(.td("Japan"), .td("Tokyo"))
        ),
        .h2("List of ", .strong("programming languages")),
        .ul(
            .li("Swift"),
            .li("Objective-C"),
            .li("C")
        )
    )
)
```

Above we’re also using Plot’s powerful composition capabilities, which lets us express all sorts of HTML hierarchies by simply adding new elements as comma-separated values.

## Applying attributes

Attributes can also be applied the exact same way as child elements are added, by simply adding another entry to an element’s comma-separated list of content. For example, here’s how an anchor element with both a CSS class and a URL can be defined:

```swift
let html = HTML(
    .body(
        .a(.class("link"), .href("https://github.com"), "GitHub")
    )
)
```

The fact that attributes, elements and inline text are all defined the same way both makes Plot’s API easier to learn, and also enables a really fast and fluid typing experience — as you can simply type `.` within any context to keep defining new attributes and elements.

## Type safety built-in

Plot makes heavy use of Swift’s advanced generics capabilities to not only make it *possible* to write HTML and XML using native code, but to also make that process completely type-safe as well.

All of Plot’s elements and attributes are implemented as context-bound *nodes*, which both enforces valid HTML semantics, and also enables Xcode and other IDEs to provide rich autocomplete suggestions when writing code using Plot’s DSL.

For example, above the `href` attribute was added to an `<a>` element, which is completely valid. However, if we instead attempted to add that same attribute to a `<p>` element, we’d get a compiler error:

```swift
let html = HTML(.body(
    // Compiler error: Referencing static method 'href' on
    // 'Node' requires that 'HTML.BodyContext' conform to
    // 'HTMLLinkableContext'.
    .p(.href("https://github.com"))
))
```

Plot also leverages the Swift type system to verify each document’s element structure as well. For example, within HTML lists (such as `<ol>` and `<ul>`), it’s only valid to place `<li>` elements — and if we break that rule, we’ll again get a compiler error:

```swift
let html = HTML(.body(
    // Compiler error: Member 'p' in 'Node<HTML.ListContext>'
    // produces result of type 'Node<Context>', but context
    // expects 'Node<HTML.ListContext>'.
    .ul(.p("Not allowed"))
))
```

This high degree of type safety both results in a really pleasant development experience, and that the HTML and XML documents created using Plot will have a much higher chance of being semantically correct — especially when compared to writing documents and markup using raw strings.

## Components

Plot’s `Component` protocol enables you to define and render higher-level components using a very SwiftUI-like API. `Node` and `Component`-based elements can be mixed when creating an HTML document, giving you the flexibility to freely choose which way to implement which part of a website or document.

For example, let’s say that we’re building a news website using Plot, and that we’d like to render news articles in several different places. Here’s how we could define a reusable `NewsArticle` component that in turn uses a series of built-in HTML components to render its UI:

```swift
struct NewsArticle: Component {
    var imagePath: String
    var title: String
    var description: String

    var body: Component {
        Article {
            Image(url: imagePath, description: "Header image")
            H1(title)
            Span(description).class("description")
        }
        .class("news")
    }
}
```

As the above example shows, modifiers can also be applied to components to set the value of attributes, such as `class` or `id`.

To then integrate the above component into a `Node`-based hierarchy, we can simply wrap it within a `Node` using the `.component` API, like this:

```swift
func newsArticlePage(for article: NewsArticle) -> HTML {
    return HTML(.body(
        .div(
            .class("wrapper"),
            .component(article)
        )
    ))
}
```

You can also directly inline `Node`-based elements within a component’s `body`, which gives you complete freedom to mix and match between the two APIs:

```swift
struct Banner: Component {
    var title: String
    var imageURL: URLRepresentable

    var body: Component {
        Div {
            Node.h2(.text(title))
            Image(imageURL)
        }
        .class("banner")
    }
}
```

It’s highly recommended that you use the above component-based approach as much as possible when building websites and documents with Plot — as doing so will let you build up a growing library of reusable components, which will most likely accelerate your overall workflow over time.

However, note that the `Component` API can currently only be used to define elements that appear within the `<body>` of an HTML page. For `<head>` elements, or non-HTML elements, the `Node`-based API always has to be used.

Another important note is that, although Plot has been heavily optimized across the board, `Component`-based elements do require a bit of extra processing compared to `Node`-based ones — so in situations where maximum performance is required, you might want to stick to the `Node`-based API.

## Using the component environment

Just like SwiftUI views, Plot components can pass values downwards through a hierarchy using an *environment API*. Once a value has been entered into the environment using an `EnvironmentKey` and the `environmentValue` modifier, it can then be retrieved by defining a property marked with the `@EnvironmentValue` attribute within a `Component` implementation.

In the following example, the environment API is used to enable a `Page` component to assign a given `class` to all `ActionButton` components that appear within its hierarchy:

```swift
// We start by defining a custom environment key that can be
// used to enter String values into the environment:
extension EnvironmentKey where Value == String {
    static var actionButtonClass: Self {
        Self(defaultValue: "action-button")
    }
}

struct Page: Component {
    var body: Component {
        Div {
            InfoView(title: "...", text: "...")
        }
        // Here we enter a custom action button class
        // into the environment, which will apply to
        // all child components within our above Div:
        .environmentValue("action-button-large",
            key: .actionButtonClass
        )
    }
}

// Our info view doesn't have to have any awareness of
// our environment value. Plot will automatically pass
// it down to the action buttons defined below:
struct InfoView: Component {
    var title: String
    var text: String

    var body: Component {
        Div {
            H2(title)
            Paragraph(text)
            ActionButton(title: "OK")
            ActionButton(title: "Cancel")
        }
        .class("info-view")
    }
}

struct ActionButton: Component {
    var title: String

    // Here we pick up the current environment value for
    // our custom "actionButtonClass" key, which in this
    // example will be the value that our "Page" component
    // entered into the environment:
    @EnvironmentValue(.actionButtonClass) var className

    var body: Component {
        Button(title).class(className)
    }
}
```

Plot also ships with several components that utilize the environment API for customization. For example, you can change the style of all `List` components within a hierarchy using the `listStyle` key/modifier, and the `linkRelationship` key/modifier lets you tweak the `rel` attribute of all `Link` components within a hierarchy.

## Inline control flow

Since Plot is focused on static site generation, it also ships with several control flow mechanisms that let you inline logic when using either its `Node`-based or `Component`-based APIs. For example, using the `.if()` command, you can optionally add a node only when a given condition is `true`, and within a component’s `body`, you can simply inline a regular `if` statement to do the same thing:

```swift
let rating: Rating = ...

// When using the Node-based API:
let html = HTML(.body(
    .if(rating.hasEnoughVotes,
        .span("Average score: \(rating.averageScore)")
    )
))

// When using the Component API:
let html = HTML {
    if rating.hasEnoughVotes {
        Span("Average score: \(rating.averageScore)")
    }
}
```

You can also attach an `else` clause to the node-based `.if()` command as well, which will act as a fallback node to be displayed when the command’s condition is `false`. You can also use a standard `else` clause when using the component API:

```swift
// When using the Node-based API:
let html = HTML(.body(
    .if(rating.hasEnoughVotes,
        .span("Average score: \(rating.averageScore)"),
        else: .span("Not enough votes yet.")
    )
))

// When using the Component API:
let html = HTML {
    if rating.hasEnoughVotes {
        Span("Average score: \(rating.averageScore)")
    } else {
        Span("Not enough votes yet.")
    }
}
```

Optional values can also be unwrapped inline using the `Node`-based `.unwrap()` command, which takes an optional to unwrap, and a closure used to transform its value into a node. When using the `Component`-based API, you can simply use a standard `if let` expression to do the same thing.

Here’s how those capabilities could be used to conditionally display a part of an HTML page only if a user is logged in. 

```swift
let user: User? = loadUser()

// When using the Node-based API:
let html = HTML(.body(
    .unwrap(user) {
        .p("Hello, \($0.name)")
    }
))

// When using the Component-based API:
let html = HTML {
    if let user = user {
        Paragraph("Hello, \(user.name)")
    }
}
```

Just like `.if()`, the `.unwrap()` command can also be passed an `else` clause that will be used if the optional being unwrapped turned out to be `nil` (and the equivalent logic can once again be implemented using a standard `else` clause when using the `Component`-based API):

```swift
let user: User? = loadUser()

// When using the Node-based API:
let html = HTML(.body(
    .unwrap(user, {
        .p("Hello, \($0.name)")
    },
    else: .text("Please log in")
    )
))

// When using the Component-based API:
let html = HTML {
    if let user = user {
        Paragraph("Hello, \(user.name)")
    } else {
        Text("Please log in")
    }
}
```

Finally, the `.forEach()` command can be used to transform any Swift `Sequence` into a group of nodes, which is incredibly useful when constructing `Node`-based lists. When building `Component`-based lists, you could either directly pass your sequence to the built-in `List` component, or use a `for` loop:

```swift
let names: [String] = ...

// When using the Node-based API:
let html = HTML(.body(
    .h2("People"),
    .ul(.forEach(names) {
        .li(.class("name"), .text($0))
    })
))

// When using the Component-based API:
let html = HTML {
    H2("People")

    // Passing our array directly to List:
    List(names) { name in
        ListItem(name).class("name")
    }

    // Using a manual for loop within a List closure:
    List {
        for name in names {
            ListItem(name).class("name")
        }
    }
}
```

Using the above control flow mechanisms, especially when combined with the approach of defining custom components, lets you build really flexible templates, documents and HTML pages — all in a completely type-safe way.

## Custom elements and attributes

While Plot aims to cover as much of the standards associated with the document formats that it supports (see [“Compatibility with standards”](#compatibility-with-standards) for more info), chances are that you’ll eventually encounter some form of element or attribute that Plot doesn’t yet cover.

Thankfully, Plot also makes it trivial to define custom elements and attributes — which is both useful when building more free-form XML documents, and as an *“escape hatch”* when Plot does not yet support a given part of a standard:

```swift
// When using the Node-based API:
let html = HTML(.body(
    .element(named: "custom", text: "Hello..."),
    .p(
        .attribute(named: "custom", value: "...world!")
    )
))

// When using the Component-based API:
let html = HTML {
    Element(name: "custom") {
        Text("Hello...")
    }

    Paragraph().attribute(
        named: "custom",
        value: "...world!"
    )
}
```

While the above APIs are great for constructing one-off custom elements, or for temporary working around a limitation in Plot’s built-in functionality, it’s (in most cases) recommended to instead either:

- [Add and submit](CONTRIBUTING.md#adding-a-new-node-type) the missing API if it’s for an element or attribute that Plot should ideally cover.
- Define your own type-safe elements and attributes the same way Plot does — by first extending the relevant document format in order to add your own context type, and then extending the `Node` type with your own DSL APIs:

```swift
extension XML {
    enum ProductContext {}
}

extension Node where Context == XML.DocumentContext {
    static func product(_ nodes: Node<XML.ProductContext>...) -> Self {
        .element(named: "product", nodes: nodes)
    }
}

extension Node where Context == XML.ProductContext {
    static func name(_ name: String) -> Self {
        .element(named: "name", text: name)
    }

    static func isAvailable(_ bool: Bool) -> Self {
        .attribute(named: "available", value: String(bool))
    }
}
```

The above may at first seem like unnecessary busywork, but just like Plot itself, it can really improve the stability and predictability of your custom documents going forward.

## Rendering a document

Once you’ve finished constructing a document using Plot’s DSL, call the `render` method to render it into a `String`, which can optionally be indented using either tabs or spaces:

```swift
let html = HTML(...)

let nonIndentedString = html.render()
let spacesIndentedString = html.render(indentedBy: .spaces(4))
let tabsIndentedString = html.render(indentedBy: .tabs(1))
```

Individual nodes can also be rendered independently, which makes it possible to use Plot to construct just a single part of a larger document:

```swift
let header = Node.header(
    .h1("Title"),
    .span("Description")
)

let string = header.render()
```

Just like nodes, components can also be rendered on their own:

```
let header = Header {
    H1("Title")
    Span("Description")
}

let string = header.render()
```

Plot was built with performance in mind, so regardless of how you render a document, the goal is for that rendering process to be as fast as possible — with very limited node tree traversal and as little string copying and interpolation as possible.

## RSS feeds, podcasting, and site maps

Besides HTML and free-form XML, Plot also ships with DSL APIs for constructing RSS and podcast feeds, as well as SiteMap XMLs for search engine indexing.

While these APIs are most likely only relevant when building tools and custom generators (the upcoming static site generator Publish includes implementations of all of these formats), they provide the same level of type safety as when building HTML pages using Plot:

```swift
let rss = RSS(
    .item(
        .guid("https://mysite.com/post", .isPermaLink(true)),
        .title("My post"),
        .link("https://mysite.com/post")
    )
)

let podcastFeed = PodcastFeed(
    .title("My podcast"),
    .owner(
        .name("John Appleseed"),
        .email("john.appleseed@url.com")
    ),
    .item(
        .title("My first episode"),
        .audio(
            url: "https://mycdn.com/episode.mp3",
            byteSize: 79295410,
            title: "My first episode"
        )
    )
)

let siteMap = SiteMap(
    .url(
        .loc("https://mysite.com/post"),
        .lastmod(Date()),
        .changefreq(.daily),
        .priority(1)
    )
)
```

For more information about what data is required to build a podcast feed, see [Apple’s podcasting guide](https://itunespartner.apple.com/podcasts), and for more information about the SiteMap format, see [its official spec](https://www.sitemaps.org/protocol.html).

## System requirements

To be able to successfully use Plot, make sure that your system has Swift version 5.4 (or later) installed. If you’re using a Mac, also make sure that `xcode-select` is pointed at an Xcode installation that includes the required version of Swift, and that you’re running macOS Big Sur (11.0) or later. 

Please note that Plot **does not** officially support any form of beta software, including beta versions of Xcode and macOS, or unreleased versions of Swift.

## Installation

Plot is distributed using the [Swift Package Manager](https://swift.org/package-manager). To install it into a project, simply add it as a dependency within your `Package.swift` manifest:

```swift
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/johnsundell/plot.git", from: "0.9.0")
    ],
    ...
)
```

Then import Plot wherever you’d like to use it:

```swift
import Plot
```

For more information on how to use the Swift Package Manager, check out [this article](https://www.swiftbysundell.com/articles/managing-dependencies-using-the-swift-package-manager), or [its official documentation](https://github.com/apple/swift-package-manager/tree/master/Documentation).

## Navigating Plot’s API and implementation

Plot consists of four core parts, that together make up both its DSL and its overall document rendering API:

- [`Node`](Sources/Plot/API/Node.swift) is the core building block for all elements and attributes within any Plot document. It can represent elements and attributes, as well as text content and groups of nodes. Each node is bound to a `Context` type, which determines which kind of DSL APIs that it gets access to (for example `HTML.BodyContext` for nodes placed within the `<body>` of an HTML page).
- [`Element`](Sources/Plot/API/Element.swift) represents an element, and can either be opened and closed using two separate tags (like `<body></body>`) or self-closed (like `<img/>`). You normally don’t have to interact with this type when using Plot, since you can create instances of it through its DSL.
- [`Attribute`](Sources/Plot/API/Attribute.swift) represents an attribute attached to an element, such as the `href` of an `<a>` element, or the `src` of an `<img>` element. You can either construct `Attribute` values through its initializer, or through the DSL, using the `.attribute()` command.
- The [`Component`](Sources/Plot/API/Component.swift) protocol is used to define components in a very SwiftUI-like way. Every component needs to implement a `body` property, in which its rendered output can be constructed using either other components, or `Node`-based elements.
- [`Document` and `DocumentFormat`](Sources/Plot/API/Document.swift) represent documents of a given format, such as `HTML`, `RSS` and `PodcastFeed`. These are the top level types that you use in order to start a document building session using Plot’s DSL.

Plot makes heavy use of a technique known as *[Phantom Types](https://www.swiftbysundell.com/articles/phantom-types-in-swift)*, which is when types are used as “markers” for the compiler, to be able to enforce type safety through [generic constraints](https://www.swiftbysundell.com/articles/using-generic-type-constraints-in-swift-4). Both `DocumentFormat`, and the `Context` of a node, element or attribute, are used this way — as these types are never instantiated, but rather just there to associate their values with a given context or format.

Plot also uses a very [lightweight API design](https://www.swiftbysundell.com/articles/lightweight-api-design-in-swift), minimizing external argument labels in favor of reducing the amount of syntax needed to render a document — giving its API a very “DSL-like” design.

The `Component` API uses the [Result Builders](https://swiftbysundell.com/articles/deep-dive-into-swift-function-builders) and [Property Wrappers](https://swiftbysundell.com/articles/property-wrappers-in-swift) language features to bring its very SwiftUI-like API to life. 

## Compatibility with standards

Plot’s ultimate goal to be fully compatible with all standards that back the document formats that it supports. However, being a very young project, it will most likely need the community’s help to move it closer to that goal.

The following standards are intended to be covered by Plot’s DSL:

- [HTML 5.0](https://html.spec.whatwg.org)
- [XML 1.0](https://www.w3.org/TR/REC-xml)
- [RSS 2.0](https://validator.w3.org/feed/docs/rss2.html)
- [Apple’s RSS extensions for podcasts](https://help.apple.com/itc/podcasts_connect/#/itcbaf351599)
- [The Sitemaps XML format](https://www.sitemaps.org/protocol.html)

Note that the `Component` API currently only covers a subset of the HTML 5.0 spec, and can currently only be used to define elements within the `<body>` of an HTML page.

If you discover an element or attribute that’s missing, please [add it](CONTRIBUTING.md#adding-a-new-node-type) and open a Pull Request with that addition.

## Credits, alternatives and focus

Plot was originally written by [John Sundell](https://twitter.com/johnsundell) as part of the Publish suite of static site generation tools, which is used to build and generate [Swift by Sundell](https://swiftbysundell.com). That suite also includes the Markdown parser [Ink](https://github.com/JohnSundell/Ink), as well as [Publish](https://github.com/JohnSundell/Publish) itself.

The idea of using Swift to generate HTML has also been explored by many other people and projects in the community, some of them similar to Plot, some of them completely different. For example [Leaf](https://github.com/vapor/leaf) by [Vapor](https://vapor.codes), [swift-html](https://github.com/pointfreeco/swift-html) by [Point-Free](https://www.pointfree.co), and the [Swift Talk backend](https://github.com/objcio/swift-talk-backend) by [objc.io](https://www.objc.io). The fact that there’s a lot of simultaneous innovation within this area is a great thing — since all of these tools (including Plot) have made different decisions around their overall API design and scope, which lets each developer pick the tool that best fits their individual taste and needs (or perhaps build yet another one?).

Plot’s main focus is on Swift-based static site generation, and on supporting a wide range of formats used when building websites, including RSS and podcast feeds. It’s also tightly integrated with the [Publish static site generator](https://github.com/JohnSundell/Publish), and was built to enable Publish to be as fast and flexible as possible, without having to take on any third-party dependencies. It was open sourced as a separate project both from an architectural perspective, and to enable other tools to be built on top of it without having to depend on Publish.

## Contributions and support

Plot is developed completely in the open, and your contributions are more than welcome.

Before you start using Plot in any of your projects, it’s highly recommended that you spend a few minutes familiarizing yourself with its documentation and internal implementation, so that you’ll be ready to tackle any issues or edge cases that you might encounter.

Since this is still a young project, it’s likely to have many limitations and missing features, which is something that can really only be discovered and addressed as more people start using it. While Plot is used in production to build and render all of [Swift by Sundell](https://swiftbysundell.com), it’s recommended that you first try it out for your specific use case, to make sure it supports the features that you need.

This project does [not come with GitHub Issues-based support](CONTRIBUTING.md#bugs-feature-requests-and-support), or any other kind of direct support channels, and users are instead encouraged to become active participants in its continued development — by fixing any bugs that they encounter, or by improving the documentation wherever it’s found to be lacking.

If you wish to make a change, [open a Pull Request](https://github.com/JohnSundell/Plot/pull/new) — even if it just contains a draft of the changes you’re planning, or a test that reproduces an issue — and we can discuss it further from there. See [Plot’s contribution guide](CONTRIBUTING.md) for more information about how to contribute to this project.

Hope you’ll enjoy using Plot!