/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

public extension Attribute where Context == XML.DeclarationContext {
    /// Declare the XML version used to define the document.
    /// - parameter version: The XML document's version.
    static func version(_ version: Double) -> Attribute {
        Attribute(name: "version", value: String(version))
    }

    /// Declare the encoding used to define the document's content.
    /// - parameter encoding: The XML document's encoding.
    static func encoding(_ encoding: DocumentEncoding) -> Attribute {
        Attribute(name: "encoding", value: encoding.rawValue)
    }
}
