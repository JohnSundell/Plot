/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Foundation

/// A representation of an HTML document. Create an instance of this
/// type to build a web page using Plot's type-safe DSL, and then
/// call the `render()` method to turn it into an HTML string.
public struct HTML: DocumentFormat {
    private let document: Document<HTML>
    private var environmentOverrides = [Environment.Override]()

    /// Create an HTML document with a collection of nodes that make
    /// up its elements and attributes. Start by specifying its root
    /// nodes, such as `.head()` and `.body()`, and then create any
    /// sort of hierarchy of elements and attributes from there.
    /// - parameter nodes: The root nodes of the document, which will
    /// be placed inside of an `<html>` element.
    public init(_ nodes: Node<HTML.DocumentContext>...) {
        document = Document(elements: [
            .doctype("html"),
            .html(.group(nodes))
        ])
    }
}

public extension HTML {
    /// Create an HTML document with a set of `<head>` nodes and a closure
    /// that defines the components that should make up its `<body>`.
    /// - parameter head: The nodes that should be placed within this HTML
    ///   document's `<head>` element.
    /// - parameter body: A closure that defines a set of components that
    ///   should be placed within this HTML document's `<body>` element.
    init(head: [Node<HTML.HeadContext>] = [],
         @ComponentBuilder body: @escaping () -> Component) {
        self.init(
            .if(!head.isEmpty, .head(.group(head))),
            .body(body)
        )
    }

    /// Place a value into the environment used to render this HTML document and
    /// any components within it. An environment value will be passed downwards
    /// through a component/node hierarchy until its overriden by another value
    /// for the same key.
    /// - parameter value: The value to add. Must match the type of the key that
    ///   it's being added for. This value will override any value that was assigned
    ///   by a parent component for the same key, or the key's default value.
    /// - parameter key: The key to associate the value wth. You can either use any
    ///   of the built-in key definitions that Plot ships with, or define your own.
    ///   See `EnvironmentKey` for more information.
    func environmentValue<T>(_ value: T, key: EnvironmentKey<T>) -> HTML {
        var html = self
        html.environmentOverrides.append(.init(key: key, value: value))
        return html
    }
}

extension HTML: NodeConvertible {
    public var node: Node<Self> {
        if environmentOverrides.isEmpty {
            return document.node
        }

        return ModifiedComponent(
            base: document.node,
            environmentOverrides: environmentOverrides
        )
        .convertToNode()
    }
}

public extension HTML {
    /// The root context of an HTML document. Plot automatically
    /// creates all required elements within this context for you.
    enum RootContext {}
    /// The user-facing root context of an HTML document. Elements
    /// like `<head>` and `<body>` are placed within this context.
    enum DocumentContext: HTMLStylableContext {}
    /// The context within an HTML document's `<head>` element.
    enum HeadContext: HTMLContext, HTMLScriptableContext {}
    /// The context within an HTML document's `<body>` element.
    class BodyContext: HTMLStylableContext, HTMLScriptableContext, HTMLImageContainerContext {}
    /// The context within an HTML `<a>` element.
    final class AnchorContext: BodyContext, HTMLLinkableContext {}
    /// The context within an HTML `<audio>` element.
    enum AudioContext: HTMLMediaContext {
        public typealias SourceContext = AudioSourceContext
    }
    /// The context within an audio `<source>` element.
    enum AudioSourceContext: HTMLSourceContext {}
    /// The context within an HTML `<button>` element.
    final class ButtonContext: BodyContext, HTMLNamableContext, HTMLValueContext {}
    /// The context within an HTML `<data>` element.
    class DataContext: BodyContext, HTMLValueContext {}
    /// The context within an HTML `<datalist>` element.
    enum DataListContext: HTMLOptionListContext {}
    /// The context within an HTML `<dl>` element.
    enum DescriptionListContext: HTMLStylableContext {}
    /// The context within an HTML `<details>` element.
    final class DetailsContext: BodyContext {}
    /// The context within an HTML `<embed>` element.
    enum EmbedContext: HTMLStylableContext, HTMLSourceContext, HTMLTypeContext, HTMLDimensionContext {}
    /// The context within an HTML `<form>` element.
    final class FormContext: BodyContext {}
    /// The context within an HTML `<iframe>` element.
    enum IFrameContext: HTMLNamableContext, HTMLSourceContext {}
    /// The context within an HTML `<img>` element.
    enum ImageContext: HTMLSourceContext, HTMLStylableContext, HTMLDimensionContext {}
    /// The context within an HTML `<input>` element.
    enum InputContext: HTMLNamableContext, HTMLValueContext {}
    /// The context within an HTML `<textarea>` element.
    final class TextAreaContext: HTMLNamableContext {}
    /// The context within an HTML `<label>` element.
    final class LabelContext: BodyContext {}
    /// The context within an HTML `<link>` element.
    enum LinkContext: HTMLLinkableContext, HTMLTypeContext, HTMLIntegrityContext {}
    /// The context within an HTML list, such as `<ul>` or `<ol>` elements.
    enum ListContext: HTMLStylableContext {}
    /// The context within an HTML `<meta>` element.
    enum MetaContext: HTMLNamableContext {}
    /// The context within an HTML `<option>` element.
    enum OptionContext: HTMLValueContext {}
    /// The context within an HTML `<picture>` element.
    enum PictureContext: HTMLSourceListContext, HTMLImageContainerContext {
        public typealias SourceContext = PictureSourceContext
    }
    /// The context within a picture `<source>` element.
    enum PictureSourceContext {}
    /// The context within an HTML `<script>` element.
    enum ScriptContext: HTMLSourceContext, HTMLIntegrityContext {}
    /// The context within an HTML `<select>` element.
    enum SelectContext: HTMLOptionListContext {}
    /// The context within an HTML `<table>` element.
    enum TableContext: HTMLStylableContext {}
    /// The context within an HTML `<tr>` element.
    enum TableRowContext: HTMLStylableContext {}
    /// The context within an HTML `<video>` element.
    enum VideoContext: HTMLMediaContext {
        public typealias SourceContext = VideoSourceContext
    }
    /// The context within a video `<source>` element.
    enum VideoSourceContext: HTMLSourceContext {}
}

/// Context shared among all HTML elements.
public protocol HTMLContext {}
/// Context shared among all HTML elements that can have their dimensions
/// (width and height) specified through attributes, such as `<video>`.
public protocol HTMLDimensionContext: HTMLContext {}
/// Context shared among all HTML elements that can contain an `<img>` element.
public protocol HTMLImageContainerContext: HTMLContext {}
/// Context shared among all HTML elements that act as some form
/// of link to an external resource, such as `<link>` or `<a>`.
public protocol HTMLLinkableContext: HTMLContext {}
/// Context shared among all HTML elements that enable media playback,
/// such as `<audio>` and `<video>`.
public protocol HTMLMediaContext: HTMLSourceListContext {}
/// Context shared among all HTML elements that support the `integrity`
/// attribute, such as `<link>` and `<script>`
public protocol HTMLIntegrityContext: HTMLContext {}
/// Context shared among all HTML elements that support the `name`
/// attribute, such as `<meta>` and `<input>`.
public protocol HTMLNamableContext: HTMLContext {}
/// Context shared among all HTML elements that are lists of options,
/// such as `<select>` and `<datalist>`.
public protocol HTMLOptionListContext: HTMLContext {}
/// Context shared between `<head>` and `<body>`, in which scripts
/// can be inlined or referenced.
public protocol HTMLScriptableContext: HTMLContext {}
/// Context shared among all HTML elements that support the `src`
/// attribute, for example `<img>` and `<iframe>`.
public protocol HTMLSourceContext: HTMLContext {}
/// Context shared among all HTML elements that can act as containers
/// for a list of `<source>` elements.
public protocol HTMLSourceListContext: HTMLContext {
    /// The context within the element's `<source>` child elements.
    associatedtype SourceContext
}
/// Context shared among all HTML elements that can be styled using
/// inline CSS through the `style` attribute.
public protocol HTMLStylableContext: HTMLContext {}
/// Context shared among all HTML elements that support a free-form
/// `type` attribute, such `<link>` and `<embed>`.
public protocol HTMLTypeContext: HTMLContext {}
/// Context shared among all HTML elements that support the `value`
/// attribute, such as `<data>`, `<option>`, and `<input>`.
public protocol HTMLValueContext: HTMLContext {}
