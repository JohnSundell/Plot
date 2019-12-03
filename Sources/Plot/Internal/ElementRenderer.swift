/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Foundation

internal final class ElementRenderer {
    private let elementName: String
    private let paddingCharacter: Character?
    private let indentation: Indentation?
    private var attributes = [AnyAttribute]()
    private var attributeIndexes = [String : Int]()
    private var body = ""
    private var containsChildElements = false

    init(elementName: String,
         paddingCharacter: Character?,
         indentation: Indentation?) {
        self.elementName = elementName
        self.paddingCharacter = paddingCharacter
        self.indentation = indentation
    }

    func addElement<C>(_ element: Element<C>) {
        if indentation != nil {
            body.append("\n")
        }

        body.append(element.render(indentedBy: indentation?.indented()))
        containsChildElements = true
    }

    func addAttribute<C>(_ attribute: Attribute<C>) {
        guard !attribute.name.isEmpty else { return }

        if let index = attributeIndexes[attribute.name] {
            attributes[index] = attribute
            return
        }

        attributes.append(attribute)
        attributeIndexes[attribute.name] = attributes.count - 1
    }

    func addText(_ text: String) {
        addRawText(text.escaped())
    }

    func addRawText(_ text: String) {
        body.append(text)
    }

    func render<C>(withClosingMode closingMode: Element<C>.ClosingMode) -> String {
        guard !elementName.isEmpty else { return body }

        let whitespace = indentation?.string ?? ""
        let padding = paddingCharacter.map(String.init) ?? ""
        var openingTag = "\(whitespace)<\(padding)\(elementName)"

        for attribute in attributes {
            let string = attribute.render()

            if !string.isEmpty {
                openingTag.append(" " + string)
            }
        }

        let openingTagSuffix = padding + ">"

        switch closingMode {
        case .standard,
             .selfClosing where containsChildElements:
            var string = openingTag + openingTagSuffix + body

            if indentation != nil && containsChildElements {
                string.append("\n\(whitespace)")
            }

            return string + "</\(elementName)>"
        case .neverClosed:
            return openingTag + openingTagSuffix + body
        case .selfClosing:
            return openingTag + "/" + openingTagSuffix
        }
    }
}
