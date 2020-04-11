//
//  SVGAttributes.swift
//  plotSVG
//
//  Created by Klaus Kneupner on 25/03/2020.
//

import AppKit.NSColor
import AppKit.NSFont

//public extension Attribute where Context == XML.DeclarationContext {
//       /// Declare the XML version used to define the document.
//       /// - parameter version: The XML document's version.
//       static func version(_ version: Double) -> Attribute {
//           Attribute(name: "version", value: String(version))
//       }
//
//       /// Declare the encoding used to define the document's content.
//       /// - parameter encoding: The XML document's encoding.
//       static func encoding(_ encoding: DocumentEncoding) -> Attribute {
//           Attribute(name: "encoding", value: encoding.rawValue)
//       }
//   }


public extension Node where Context == SVGDoc.SVGContext {

   
    /// Add a namespace to this RSS feed.
    /// - parameter name: The name of the namespace to add.
    /// - parameter url: The URL of the namespace's definition.
    static func namespace(_ name: String, _ url: URLRepresentable) -> Node {
        return .attribute(named: "xmlns:\(name)", value: url.description)
    }
    static func viewport(_ vp: String) -> Node {
        return .attribute(named: "viewport", value: vp)
    }
}

public extension Node where Context :SVGBaseContext {
    /// see https://www.w3.org/TR/SVG2/struct.html#IDAttribute
    static func id(_ value: String) -> Node {
        assert(!value.contains(" "))
        return .attribute(named: "id", value: value)
    }
    
    /// see https://www.w3.org/TR/2014/CR-html5-20140204/dom.html#custom-data-attribute
    static func data(nameAfterHyphen: String, _ value: String) -> Node {
        return .attribute(named: "data-\(nameAfterHyphen)", value: value)
    }
}


public extension Node where Context == SVGDoc.PathContext {
    /// https://www.w3.org/TR/SVG2/paths.html#DProperty
    static func d(_ value: String) -> Node {
        return .attribute(named: "d", value: value)
    }
}




public extension Node where Context : SVGSizableContext {
    /// https://www.w3.org/TR/SVG2/geometry.html#X
    static func x(_ value: Double) -> Node {
        return .attribute(named: "x", value: value.asString())
    }
    
    /// https://www.w3.org/TR/SVG2/geometry.html#X
    static func x(_ length: SVGLength) -> Node {
        return .attribute(named: "x", value: length.value.asString() + length.unit.rawValue)
    }
    
    /// https://www.w3.org/TR/SVG2/geometry.html#Y
    static func y(_ value: Double) -> Node {
        return .attribute(named: "y", value: value.asString())
    }
    
    /// https://www.w3.org/TR/SVG2/geometry.html#Y
    static func y(_ length: SVGLength) -> Node {
        return .attribute(named: "y", value: length.value.asString() + length.unit.rawValue)
    }
    
    /// https://www.w3.org/TR/SVG2/geometry.html#Y
    static func width(_ value: Double) -> Node {
        return .attribute(named: "width", value: value.asString())
    }
    
    /// https://www.w3.org/TR/SVG2/geometry.html#Y
    static func width(_ length: SVGLength) -> Node {
        return .attribute(named: "width", value: length.value.asString() + length.unit.rawValue)
    }
    
}

public extension Node where Context == SVGDoc.TextContext {
    static func x(_ value: Double) -> Node {
        return .attribute(named: "x", value: value.asString())
    }
    static func y(_ value: Double) -> Node {
        return .attribute(named: "y", value: value.asString())
    }
    static func font_family(_ font: String) -> Node {
        return .attribute(named: "font-family", value:font)
    }
    static func font_size(_ size: Double) -> Node {
        return .attribute(named: "font-size", value: size.asString())
    }
    enum FontWeight: String {
        case normal = "normal"
        case bold = "bold"
        case bolder = "bolder"
        case lighter = "lighter"
        case _100 = "100" //thin
        case _200 = "200"
        case _300 = "300"
        case _400 = "400" //normal
        case _500 = "500"
        case _600 = "600"
        case _700 = "700" //bold
        case _800 = "800"
        case _900 = "900"
    }
    static func font_weight(_ weight : FontWeight) -> Node {
        return .attribute(named: "font-weight", value: weight.rawValue)
    }
    
    static func font_weight(font: NSFont) -> Node {
        return font_weight(font.fontDescriptor.symbolicTraits.contains(.bold) ? .bold : .normal)
    }
    
    enum DominantBaseline : String {
        case auto = "auto"
        case text_bottom = "text-bottom"
        case alphabetic = "alphabetic"
        case ideographic = "ideographic"
        case middle = "middle"
        case central = "central"
        case mathematical = "mathematical"
        case hanging = "hanging"
        case text_top = "text-top"
    }
    static func dominant_baseline(_ value : DominantBaseline) -> Node {
        return .attribute(named: "dominant-baseline", value: value.rawValue)
    }
    
    enum TextAnchor: String {
        case start = "start"
        case middle = "middle"
        case end = "end"
    }
    
    static func text_anchor(_ value : TextAnchor) -> Node {
        return .attribute(named: "text-anchor", value: value.rawValue)
    }

    static func fill(_ value: NSColor) -> Node {
        return .attribute(named: "fill", value: value.hexString)
    }
    static func fill_opacity(_ value: NSColor) -> Node {
        return .attribute(named: "fill-opacity", value: value.alphaComponent.asString())
    }
    static func fill(color: NSColor) -> [Node] {
        return [fill(color), fill_opacity(color)]
    }
    static func stroke(_ value: NSColor) -> Node {
           return .attribute(named: "stroke", value: value.hexString)
    }
    static func stroke_opacity(_ value: NSColor) -> Node {
           return .attribute(named: "stroke-opacity", value: value.alphaComponent.asString())
    }
    static func stroke(color: NSColor) -> [Node] {
        return [stroke(color), stroke_opacity(color)]
    }
}
