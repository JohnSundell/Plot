/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Foundation

/// Protocol used to define a document format. Plot ships with a number
/// of different implementations of this protocol, such as `HTML`, `RSS`,
/// and `XML`, but you can also create your own types by conforming to it.
///
/// Built-in document types are created simply by initializing them, while
/// custom ones can be created using the `Document.custom` APIs.
public protocol DocumentFormat {
    /// The root context of the document, which all top-level elements are
    /// bound to. Each document format is free to define any number of contexts
    /// in order to limit where an element or attribute may be placed.
    associatedtype RootContext
}

/// A representation of a document, which is the root element for all formats
/// that can be expressed using Plot. For example, an HTML document will have
/// the type `Document<HTML>`, and an RSS feed `Document<RSS>`.
///
/// You normally don't have to interact with this type directly, unless you want
/// to define your own custom document format, since the built-in formats (such
/// as `HTML`, `RSS` and `XML`) completely wrap this type. To create custom
/// `Document` values, use the `.custom` static factory methods.
public struct Document<Format: DocumentFormat> {
    /// The root elements that make up this document. See `Element` for more info.
    public var elements: [Element<Format.RootContext>]

    internal init(elements: [Element<Format.RootContext>]) {
        self.elements = elements
    }
}

public extension Document {
    /// Create a `Document` value using a custom `DocumentFormat` type, with a list
    /// of elements that make up the root of the document.
    /// - parameter elements: The new document's root elements
    static func custom(_ elements: Element<Format.RootContext>...) -> Self {
        Document(elements: elements)
    }

    /// Create a `Document` value using an explicitly passed custom `DocumentFormat`
    /// type, with a list of elements that make up the root of the document.
    /// - parameter format: The `DocumentFormat` type to bind the document to.
    /// - parameter elements: The new document's root elements
    static func custom(withFormat format: Format.Type,
                       elements: [Element<Format.RootContext>] = []) -> Self {
        Document(elements: elements)
    }
}

extension Document: NodeConvertible {
    public var node: Node<Format> { .document(self) }
}
