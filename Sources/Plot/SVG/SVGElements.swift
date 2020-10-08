//
//  SVGElements.swift
//  plotSVG
//
//  Created by Klaus Kneupner on 25/03/2020.
//



public extension Element where Context == SVGDoc.RootContext {
    /// Add a `<urlset>` element within the current context.
    /// - parameter nodes: The element's attributes and child elements.
    static func svg(_ nodes: Node<SVGDoc.SVGContext>...) -> Element  {
  //      let n = nodes[0] as Node<Any>
        return Element(name:"svg:svg", nodes: nodes)
    }
}

public extension Node where Context : SVGStructuralElementContext {
    /// Add a `<url>` element within the current context.
    /// - parameter nodes: The element's child elements.
    static func g(_ nodes: Node<SVGDoc.GContext>...) -> Node {
        .element(named: "svg:g", nodes: nodes)
    }
    
    static func svg(_ nodes: Node<SVGDoc.SVGContext>...) -> Node {
           .element(named: "svg:svg", nodes: nodes)
       }

    static func path(_ nodes: Node<SVGDoc.PathContext>...) -> Node {
        .element(named: "svg:path", nodes: nodes)
    }
}



