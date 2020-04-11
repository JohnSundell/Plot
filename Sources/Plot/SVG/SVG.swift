//
//  SVG.swift
//  plotSVG
//
//  Created by Klaus Kneupner on 25/03/2020.
//
//  Compare structure with: https://www.w3.org/TR/SVG2/

import Foundation

/// A representation of a site map, a special XML format used by search
/// engines to index web sites. Create an instance of this type to build
/// a site map using Plot's type-safe DSL, and then call the `render()`
/// method to turn it into an XML string.
public struct SVGDoc: DocumentFormat {
    private let document: Document<SVGDoc>

    /// Create a site map with a collection of nodes that make up its
    /// elements and attributes. Use the `.url()` API to create a new
    /// URL definition within the site map.
    /// - parameter nodes: The root nodes of the document, which will
    /// be placed inside of a `<urlset>` element.
    public init(_ nodes: Node<SVGDoc.SVGContext>...) {
        document = Document.custom(
            .xml(.version(1.0), .encoding(.utf8)),
            .svg(.namespace("svg", "http://www.w3.org/2000/svg"),.group(nodes))
        )
    }
}

extension SVGDoc: Renderable {
    public func render(indentedBy indentationKind: Indentation.Kind?) -> String {
        document.render(indentedBy: indentationKind)
    }
}
//
//public protocol ISVGContext {
//    /// The feed's channel context.
//    associatedtype Context: IItemContext
//}
//
//public protocol IItemContext {}


public enum SVGLengthUnits : String, QuantityUnits {
    case percent = "%"
    case pixels = "px"
    case inches = "In"
    case centimeters = "cm"
    case millimeters = "mm"
    case points = "pt"
    case picas = "pc"
    case fontSize = "em"
    case fontSmallCapSize = "ex"
    case fontCharacterUnitSize = "ch"
    case fontRootSize = "rem"
}

public typealias SVGLengthQuantity = Quantity<SVGLengthUnits>

public extension SVGDoc {
    
//    enum RootContext: XMLRootContext {}
    /// The context within a `<svg>` element.
    enum SVGContext : SVGBaseContext, SVGStructuralElementContext ,XMLRootContext, SVGSizableContext {}
    
    enum GContext : SVGStructuralElementContext {}
    
    typealias RootContext = SVGContext
    /// The context within a <texr> element
    enum TextContext : SVGBaseContext {}
    
    enum PathContext : SVGBaseContext {}
    
    enum RectContext: SVGSizableContext {}
    
    enum ImageContext: SVGSizableContext {}
    
    enum ForeignObjectContext: SVGSizableContext {}

}

public protocol SVGBaseContext {}

/// The structural elements are those which define the primary structure of an SVG document. Specifically, the following elements are structural elements: ‘defs’, ‘g’, ‘svg’, ‘symbol’ and ‘use’.
public protocol SVGStructuralElementContext :SVGBaseContext {}

public protocol SVGSizableContext : SVGBaseContext {}

internal extension SVGDoc {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
