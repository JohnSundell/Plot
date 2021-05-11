/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

// MARK: - Nodes

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

// MARK: - Element-based

/// Enum namespace that contains Plot's built-in `ElementDefinition` implementations.
public enum ElementDefinitions {
    /// Definition for the `<article>` element.
    public enum Article: ElementDefinition { public static var wrapper = Node.article }
    /// Definition for the `<button>` element.
    public enum Button: ElementDefinition { public static var wrapper = Node.button }
    /// Definition for the `<div>` element.
    public enum Div: ElementDefinition { public static var wrapper = Node.div }
    /// Definition for the `<fieldset>` element.
    public enum FieldSet: ElementDefinition { public static var wrapper = Node.fieldset }
    /// Definition for the `<footer>` element.
    public enum Footer: ElementDefinition { public static var wrapper = Node.footer }
    /// Definition for the `<h1>` element.
    public enum H1: ElementDefinition { public static var wrapper = Node.h1 }
    /// Definition for the `<h2>` element.
    public enum H2: ElementDefinition { public static var wrapper = Node.h2 }
    /// Definition for the `<h3>` element.
    public enum H3: ElementDefinition { public static var wrapper = Node.h3 }
    /// Definition for the `<h4>` element.
    public enum H4: ElementDefinition { public static var wrapper = Node.h4 }
    /// Definition for the `<h5>` element.
    public enum H5: ElementDefinition { public static var wrapper = Node.h5 }
    /// Definition for the `<h6>` element.
    public enum H6: ElementDefinition { public static var wrapper = Node.h6 }
    /// Definition for the `<header>` element.
    public enum Header: ElementDefinition { public static var wrapper = Node.header }
    /// Definition for the `<li>` element.
    public enum ListItem: ElementDefinition { public static var wrapper = Node.li }
    /// Definition for the `<nav>` element.
    public enum Navigation: ElementDefinition { public static var wrapper = Node.nav }
    /// Definition for the `<p>` element.
    public enum Paragraph: ElementDefinition { public static var wrapper = Node.p }
    /// Definition for the `<span>` element.
    public enum Span: ElementDefinition { public static var wrapper = Node.span }
    /// Definition for the `<caption>` element.
    public enum TableCaption: ElementDefinition { public static var wrapper = Node.caption }
    /// Definition for the `<td>` element.
    public enum TableCell: ElementDefinition { public static var wrapper = Node.td }
    /// Definition for the `<th>` element.
    public enum TableHeaderCell: ElementDefinition { public static var wrapper = Node.th }
}

/// A container component that's rendered using the `<article>` element.
public typealias Article = ElementComponent<ElementDefinitions.Article>
/// A container component that's rendered using the `<button>` element.
public typealias Button = ElementComponent<ElementDefinitions.Button>
/// A container component that's rendered using the `<div>` element.
public typealias Div = ElementComponent<ElementDefinitions.Div>
/// A container component that's rendered using the `<fieldset>` element.
public typealias FieldSet = ElementComponent<ElementDefinitions.FieldSet>
/// A container component that's rendered using the `<footer>` element.
public typealias Footer = ElementComponent<ElementDefinitions.Footer>
/// A container component that's rendered using the `<h1>` element.
public typealias H1 = ElementComponent<ElementDefinitions.H1>
/// A container component that's rendered using the `<h2>` element.
public typealias H2 = ElementComponent<ElementDefinitions.H2>
/// A container component that's rendered using the `<h3>` element.
public typealias H3 = ElementComponent<ElementDefinitions.H3>
/// A container component that's rendered using the `<h4>` element.
public typealias H4 = ElementComponent<ElementDefinitions.H4>
/// A container component that's rendered using the `<h5>` element.
public typealias H5 = ElementComponent<ElementDefinitions.H5>
/// A container component that's rendered using the `<h6>` element.
public typealias H6 = ElementComponent<ElementDefinitions.H6>
/// A container component that's rendered using the `<header>` element.
public typealias Header = ElementComponent<ElementDefinitions.Header>
/// A container component that's rendered using the `<li>` element.
public typealias ListItem = ElementComponent<ElementDefinitions.ListItem>
/// A container component that's rendered using the `<nav>` element.
public typealias Navigation = ElementComponent<ElementDefinitions.Navigation>
/// A container component that's rendered using the `<p>` element.
public typealias Paragraph = ElementComponent<ElementDefinitions.Paragraph>
/// A container component that's rendered using the `<span>` element.
public typealias Span = ElementComponent<ElementDefinitions.Span>
/// A container component that's rendered using the `<caption>` element.
public typealias TableCaption = ElementComponent<ElementDefinitions.TableCaption>
/// A container component that's rendered using the `<td>` element.
public typealias TableCell = ElementComponent<ElementDefinitions.TableCell>
/// A container component that's rendered using the `<th>` element.
public typealias TableHeaderCell = ElementComponent<ElementDefinitions.TableHeaderCell>

public extension ListItem {
    /// Assign an explicit number for the item when it appears in an
    /// ordered list. Maps to the `value` attribute.
    /// - parameter number: The number to apply.
    func number(_ number: Int) -> Component {
        attribute(named: "value", value: String(number))
    }
}

// MARK: - Component implementations

/// Component used to render an `<audio>` element for inline audio playback.
public struct AudioPlayer: Component {
    /// Type used to define an audio player source, which points to an audio file.
    public struct Source {
        /// Use an MP3 file at a given URL.
        /// - parameter url: The URL of the audio file to use.
        public static func mp3(at url: URLRepresentable) -> Self {
            Source(url: url, format: .mp3)
        }

        /// Use a WAV file at a given URL.
        /// - parameter url: The URL of the audio file to use.
        public static func wav(at url: URLRepresentable) -> Self {
            Source(url: url, format: .wav)
        }

        /// Use an OGG file at a given URL.
        /// - parameter url: The URL of the audio file to use.
        public static func ogg(at url: URLRepresentable) -> Self {
            Source(url: url, format: .ogg)
        }

        /// The URL of the audio file to use.
        public var url: URLRepresentable
        /// The audio file's format. See `HTMLAudioFormat` for more info.
        public var format: HTMLAudioFormat

        /// Create a new source.
        /// - parameter url: The URL of the audio file to use.
        /// - parameter format: The audio file's format. See `HTMLAudioFormat` for more info.
        public init(url: URLRepresentable, format: HTMLAudioFormat) {
            self.url = url
            self.format = format
        }
    }

    /// The sources that the player's audio files should be fetched from.
    public var sources: [Source]
    /// Whether the audio player should show its in-browser controls.
    public var showControls: Bool

    /// Initialize an audio player with a set of playback sources.
    /// - parameter sources: The sources that the player's audio files should
    ///   be fetched from.
    /// - parameter showControls: Whether the audio player should show its
    ///   in-browser controls.
    public init(sources: [Source], showControls: Bool) {
        self.sources = sources
        self.showControls = showControls
    }

    /// Initialize an audio player with a single playback source.
    /// - parameter source: The source that the player's audio file should
    ///   be fetched from.
    /// - parameter showControls: Whether the audio player should show its
    ///   in-browser controls.
    public init(source: Source, showControls: Bool) {
        self.init(sources: [source], showControls: showControls)
    }

    public var body: Component {
        Node.audio(
            .controls(showControls),
            .forEach(sources) { source in
                .source(.type(source.format), .src(source.url))
            }
        )
    }
}

/// Component used to render a `<form>` element for user-submittable data.
public struct Form: Component {
    /// The URL that the form's data should be submitted to.
    public var url: URLRepresentable
    /// The HTTP request method that should be used when submitting the form.
    public var method: HTMLFormMethod?
    /// The way that the form's data should be encoded when submitted.
    public var contentType: HTMLFormContentType?
    /// Whether the browser should validate the form before submission.
    public var enableValidation: Bool
    /// A closure that provides the form's child components.
    @ComponentBuilder public var content: ContentProvider

    /// Create a new form instance.
    /// - parameters:
    ///   - url: The URL that the form's data should be submitted to.
    ///   - method: The HTTP request method that should be used when submitting the form.
    ///   - contentType: The way that the form's data should be encoded when submitted.
    ///   - enableValidation: Whether the browser should validate the form before submission.
    ///   - content: A closure that provides the form's child components.
    public init(
        url: URLRepresentable,
        method: HTMLFormMethod? = nil,
        contentType: HTMLFormContentType? = nil,
        enableValidation: Bool = true,
        @ComponentBuilder content: @escaping ContentProvider
    ) {
        self.url = url
        self.method = method
        self.contentType = contentType
        self.enableValidation = enableValidation
        self.content = content
    }

    public var body: Component {
        Node.form(
            .action(url),
            .unwrap(method, Node.method),
            .unwrap(contentType, Node.enctype),
            .novalidate(!enableValidation),
            .component(content())
        )
    }
}

/// Component used to render an `<iframe>` element for an embedded page.
public struct IFrame: Component {
    /// The URL of the page to embed.
    public var url: URLRepresentable
    /// Whether a border should be added around the element.
    public var addBorder: Bool
    /// Whether the embedded page should be allowed to enter full screen mode.
    public var allowFullScreen: Bool
    /// What browser features that the embedded page should have access to.
    public var enabledFeatureNames: [String]

    /// Create a new iframe instance.
    /// - parameters:
    ///   - url: The URL of the page to embed.
    ///   - addBorder: Whether a border should be added around the element.
    ///   - allowFullScreen: Whether the embedded page should be allowed to
    ///     enter full screen mode.
    ///   - enabledFeatureNames: What browser features that the embedded page
    ///     should have access to. Maps to the `allow` attribute.
    public init(url: URLRepresentable,
                addBorder: Bool,
                allowFullScreen: Bool,
                enabledFeatureNames: [String]) {
        self.url = url
        self.addBorder = addBorder
        self.allowFullScreen = allowFullScreen
        self.enabledFeatureNames = enabledFeatureNames
    }

    public var body: Component {
        Node.iframe(
            .src(url),
            .frameborder(addBorder),
            .allowfullscreen(allowFullScreen),
            .allow(enabledFeatureNames.joined(separator: "; "))
        )
    }
}

/// Component used to render an `<img>` element for displaying an image.
public struct Image: Component {
    /// The URL of the image to render.
    public var url: URLRepresentable
    /// An alternative text that describes the image in case it couldn't be
    /// loaded, or if the user is using a screen reader.
    public var description: String

    /// Create a new image instance.
    /// - parameters:
    ///   - url: The URL of the image to render.
    ///   - description: An alternative text that describes the image in case
    ///     it couldn't be loaded, or if the user is using a screen reader.
    public init(url: URLRepresentable,
                description: String) {
        self.url = url
        self.description = description
    }

    /// Create a new decorative image that doesn't have a description.
    /// - parameter url: The URL of the image to render.
    public init(_ url: URLRepresentable) {
        self.init(url: url, description: "")
    }

    public var body: Component {
        Node<HTML.BodyContext>.img(.src(url), .alt(description))
    }
}

/// Protocol adopted by components that render controls for user input.
public protocol InputComponent: Component {
    /// Whether the component's element should be automatically focused.
    var isAutoFocused: Bool { get set }
}

public extension InputComponent {
    /// Tell the browser whether the element should be automatically focused.
    /// - parameter isAutoFocused: Whether the element should be auto-focused.
    func autoFocused(_ isAutoFocused: Bool = true) -> Self {
        var input = self
        input.isAutoFocused = isAutoFocused
        return input
    }
}

/// Component used to render input controls using the `<input>` element.
public struct Input: InputComponent {
    /// The type of input to render. See `HTMLInputType` for more info.
    public var type: HTMLInputType
    /// The rendered element's name. Maps to the `name` attribute.
    public var name: String?
    /// The rendered element's value. Maps to the `value` attribute.
    public var value: String?
    /// Whether the input element should be considered required.
    public var isRequired: Bool
    /// Any placeholder to render within the input element.
    public var placeholder: String?
    public var isAutoFocused = false

    @EnvironmentValue(.isAutoCompleteEnabled) private var isAutoCompleteEnabled

    /// Create a new input component instance.
    /// - parameters:
    ///   - type: The type of input to render. See `HTMLInputType` for more info.
    ///   - name: The rendered element's name. Maps to the `name` attribute.
    ///   - value: The rendered element's value. Maps to the `value` attribute.
    ///   - isRequired: Whether the input element should be considered required.
    ///   - placeholder: Any placeholder to render within the input element.
    public init(type: HTMLInputType,
                name: String? = nil,
                value: String? = nil,
                isRequired: Bool = false,
                placeholder: String? = nil) {
        self.type = type
        self.name = name
        self.value = value
        self.isRequired = isRequired
        self.placeholder = placeholder
    }

    public var body: Component {
        Node.input(
            .type(type),
            .unwrap(name, Attribute.name),
            .unwrap(value, Attribute.value),
            .required(isRequired),
            .unwrap(placeholder, Attribute.placeholder),
            .autofocus(isAutoFocused),
            .unwrap(isAutoCompleteEnabled, Attribute.autocomplete)
        )
    }
}

/// Component used to wrap another component within a `<label>` element, which
/// is typically used to add interactive labels to inputs within a form.
public struct Label: Component {
    /// The text that the label should display.
    public var text: Text
    /// A closure that provides the label's child components.
    @ComponentBuilder public var content: ContentProvider

    /// Create a new label instance.
    /// - parameters:
    ///   - text: The text that the label should display.
    ///   - content: A closure that provides the label's child components.
    public init(_ text: Text,
                @ComponentBuilder content: @escaping ContentProvider) {
        self.text = text
        self.content = content
    }

    /// Create a new label instance.
    /// - parameters:
    ///   - text: The text that the label should display.
    ///   - content: A closure that provides the label's child components.
    public init(_ text: String,
                @ComponentBuilder content: @escaping ContentProvider) {
        self.init(Text(text), content: content)
    }

    public var body: Component {
        Node.label(.component(text), .component(content()))
    }
}

/// Component used to render a link/anchor using an `<a>` element.
public struct Link: Component {
    /// The URL that the link should point to.
    public var url: URLRepresentable
    /// A closure that provides the components that should make up the link's label.
    @ComponentBuilder public var label: ContentProvider

    @EnvironmentValue(.linkRelationship) private var relationship
    @EnvironmentValue(.linkTarget) private var target


    /// Create a new link instance.
    /// - parameters:
    ///   - url: The URL that the link should point to.
    ///   - label: A closure that provides the components that should make up
    ///     the link's label.
    public init(url: URLRepresentable,
                @ComponentBuilder label: @escaping ContentProvider) {
        self.url = url
        self.label = label
    }

    /// Create a new link instance.
    /// - parameters:
    ///   - label: The link's text-based label.
    ///   - url: The URL that the link should point to.
    public init(_ label: String, url: URLRepresentable) {
        self.init(url: url) {
            Node<HTML.BodyContext>.text(label)
        }
    }

    public var body: Component {
        Node.a(
            .href(url),
            .unwrap(relationship, Node.rel),
            .unwrap(target, Node.target),
            .component(label())
        )
    }
}

/// Component used to render a list of items, for example using a `<ul>` or
/// `<ol>` element.
///
/// How a list is rendered is determined by its `ListStyle`, which defaults
/// to `.unordered`, and can be customized using the `listStyle` modifier.
/// By default, any non-`ListItem` component that appears within a list is
/// automatically wrapped into a `ListItem`, as to always produce semantically
/// valid HTML.
public struct List<Items: Sequence>: Component {
    /// The items that the list should render.
    public var items: Items
    /// A closure that transforms the list's items into renderable components.
    public var content: (Items.Element) -> Component

    @EnvironmentValue(.listStyle) private var style

    /// Create a new list with a given set of items.
    /// - parameters:
    ///   - items: The items that the list should render.
    ///   - content: A closure that transforms the list's items into renderable components.
    public init(_ items: Items,
                content: @escaping (Items.Element) -> Component) {
        self.items = items
        self.content = content
    }

    /// Create a new list that renders a sequence of strings, each as its own item.
    /// - parameter items: The strings that the list should render.
    public init(_ items: Items) where Items.Element == String {
        self.init(items) { Text($0) }
    }

    public var body: Component {
        Element(name: style.elementName) {
            for item in items {
                style.itemWrapper(content(item))
            }
        }
    }
}

extension List: ComponentContainer where Items == ComponentGroup {
    public init(@ComponentBuilder content: @escaping ContentProvider) {
        self.init(content()) { $0 }
    }
}

/// Convenience type that can be used to create an `Input` component
/// for submitting an HTML form.
public struct SubmitButton: Component {
    /// The name of the component's element. Maps to the `name` attribute.
    public var name: String?
    /// The title of the button. Maps to the `value` attribute.
    public var title: String

    /// Create a new submit button.
    /// - parameters:
    ///   - name: The name of the component's element. Maps to the `name` attribute.
    ///   - title: The title of the button. Maps to the `value` attribute.
    public init(name: String? = nil, title: String) {
        self.name = name
        self.title = title
    }

    /// Create a new submit button without a name
    /// - parameter title: The title of the button. Maps to the `value` attribute.
    public init(_ title: String) {
        self.init(title: title)
    }

    public var body: Component {
        Input(type: .submit, name: name, value: title)
    }
}

/// Component used to render a `<table>` element.
///
/// Any non-`TableRow` component that appears within the table's `rows` closure
/// is automatically wrapped into a `TableRow`, as to always produce semantically
/// valid HTML.
///
/// When a table has either a `caption`, `header`, or `footer`, then its main rows
/// are wrapped within a `<tbody>` element. Otherwise, the rows are rendered as
/// direct children of the table itself.
public struct Table: Component {
    /// The table's caption. See `TableCaption` for more information.
    public var caption: TableCaption?
    /// The `TableRow` that makes up the table's header.
    public var header: TableRow?
    /// The `TableRow` that makes up the table's footer.
    public var footer: TableRow?
    /// A closure that provides the table's main rows.
    @ComponentBuilder public var rows: ContentProvider

    /// Create a new table instance.
    /// - parameters:
    ///   - caption: The table's caption. See `TableCaption` for more information.
    ///   - header: The `TableRow` that makes up the table's header.
    ///   - footer: The `TableRow` that makes up the table's footer.
    ///   - rows: A closure that provides the table's main rows.
    public init(
        caption: TableCaption? = nil,
        header: TableRow? = nil,
        footer: TableRow? = nil,
        @ComponentBuilder rows: @escaping ContentProvider
    ) {
        self.caption = caption
        self.header = header
        self.footer = footer
        self.rows = rows
    }

    public var body: Component {
        let rowWrapper = shouldWrapRowsInTableBody ? Node.tbody : Node.group

        return Node.table(
            .unwrap(caption, Node.component),
            .unwrap(header) {
                .thead($0.convertToHeaderNode())
            },
            rowWrapper(.forEach(rows()) { row in
                row.wrapped(using: ElementWrapper(
                    wrappingElementName: "tr",
                    body: TableRow.init
                ))
                .convertToNode()
            }),
            .unwrap(footer) {
                .tfoot(.component($0))
            }
        )
    }

    private var shouldWrapRowsInTableBody: Bool {
        caption != nil || header != nil || footer != nil
    }
}

/// Component that represents a row within a table.
///
/// You typically only use this component to create the content for a `Table`
/// component, although it can also be used by itself, as long as it's wrapped
/// within an appropriate parent element (such as `<table>` or `<tbody>`).
///
/// Any component that appears within the row's `content` closure that isn't
/// either a `TableCell` (for standard/footer rows) or `TableHeaderCell` (for
/// header rows) is automatically wrapped into such a component instance.
public struct TableRow: ComponentContainer {
    /// A closure that provides the components that the row should contain.
    @ComponentBuilder public var content: ContentProvider
    fileprivate var isHeader = false

    public init(@ComponentBuilder content: @escaping ContentProvider) {
        self.content = content
    }

    public var body: Component {
        Node.tr(.forEach(content()) {
            .component(wrap($0))
        })
    }

    fileprivate func convertToHeaderNode() -> Node<HTML.TableContext> {
        var row = self
        row.isHeader = true
        return row.convertToNode()
    }

    private func wrap(_ component: Component) -> Component {
        if isHeader {
            return component.wrappedInElement(named: "th")
        }

        return component.wrappedInElement(named: "td")
    }
}

/// Component used to render either plain or styled text.
///
/// All special characters that can't be rendered as-is within an HTML
/// document are automatically escaped when using this component.
/// To render raw, non-escaped HTML strings, use `Node.raw`.
public struct Text: Component {
    public static func +(lhs: Text, rhs: Text) -> Text {
        Text(node: .group(lhs.node, rhs.node))
    }

    public var body: Component { node }
    private var node: Node<HTML.BodyContext>

    /// Initialize a `Text` instance using a string
    /// - parameter string: The string of text that should be rendered.
    public init(_ string: String) {
        self.init(node: .text(string))
    }

    private init(node: Node<HTML.BodyContext>) {
        self.node = node
    }

    /// Turn this text bold by wrapping it in a `<b>` element.
    public func bold() -> Text {
        Text(node: .b(node))
    }

    /// Turn this text italic by wrapping it in an `<em>` element.
    public func italic() -> Text {
        Text(node: .em(node))
    }

    /// Underline this text by wrapping it in a `<u>` element.
    public func underlined() -> Text {
        Text(node: .u(node))
    }

    /// Apply strikethrough styling to this text by wrapping it
    /// in an `<s>` element.
    public func strikethrough() -> Text {
        Text(node: .s(node))
    }

    /// Add a line break after this text, using the `<br>` element.
    public func addLineBreak() -> Text {
        Text(node: .group(node, .br()))
    }
}

/// Convenience type that can be used to render a text-based `Input` component.
public struct TextField: InputComponent {
    /// The name of the text field's element. Maps to the `name` attribute.
    public var name: String?
    /// The text field's initial text value. Maps to the `value` attribute.
    public var text: String
    /// Any placeholder to render when the text field is empty.
    public var placeholder: String?
    /// Whether the text field should be required to fill in.
    public var isRequired: Bool
    /// Whether the browser should auto-focus the text field.
    public var isAutoFocused = false

    /// Create a new text field.
    /// - parameters:
    ///   - name: The name of the text field's element. Maps to the `name` attribute.
    ///   - text: The text field's initial text value. Maps to the `value` attribute.
    ///   - placeholder: Any placeholder to render when the text field is empty.
    ///   - isRequired: Whether the text field should be required to fill in.
    public init(name: String? = nil,
                text: String = "",
                placeholder: String? = nil,
                isRequired: Bool = false) {
        self.name = name
        self.text = text
        self.placeholder = placeholder
        self.isRequired = isRequired
    }

    public var body: Component {
        Input(
            type: .text,
            name: name,
            value: text,
            isRequired: isRequired,
            placeholder: placeholder
        )
        .autoFocused(isAutoFocused)
    }
}

/// Component that can be used to render a user-editable text area
/// using the `<textarea>` element.
public struct TextArea: InputComponent {
    /// The initial text that the text area should contain.
    public var text: String
    /// The name of the component's element. Maps to the `name` attribute.
    public var name: String?
    /// The vertical size of the text area, measured in rows.
    /// Maps to the `rows` attribute.
    public var numberOfRows: Int?
    /// The horizontal size of the text area, measured in columns.
    /// Maps to the `cols` attribute.
    public var numberOfColumns: Int?
    /// Whether the text area should be required to fill in.
    public var isRequired: Bool
    /// Whether the browser should auto-focus the text field.
    public var isAutoFocused = false

    /// Create a new text area.
    /// - parameters:
    ///   - text: The initial text that the text area should contain.
    ///   - name: The name of the component's element. Maps to the `name` attribute.
    ///   - numberOfRows: The vertical size of the text area, measured in rows.
    ///     Maps to the `rows` attribute.
    ///   - numberOfColumns: The horizontal size of the text area, measured in columns.
    ///     Maps to the `cols` attribute.
    ///   - isRequired: Whether the text area should be required to fill in.
    public init(text: String = "",
                name: String? = nil,
                numberOfRows: Int? = nil,
                numberOfColumns: Int? = nil,
                isRequired: Bool = false) {
        self.text = text
        self.name = name
        self.numberOfRows = numberOfRows
        self.numberOfColumns = numberOfColumns
        self.isRequired = isRequired
    }

    public var body: Component {
        Node.textarea(
            .text(text),
            .unwrap(name, Node.name),
            .unwrap(numberOfRows, Node.rows),
            .unwrap(numberOfColumns, Node.cols),
            .required(isRequired),
            .unwrap(isAutoFocused, Node.autofocus)
        )
    }
}
