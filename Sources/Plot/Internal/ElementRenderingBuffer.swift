/**
*  Plot
*  Copyright (c) John Sundell 2021
*  MIT license, see LICENSE file for details
*/

internal final class ElementRenderingBuffer {
    var containsChildElements = false

    private let element: AnyElement
    private let indentation: Indentation?
    private var body = ""
    private var attributes = [AnyAttribute]()
    private var attributeIndexes = [String : Int]()

    init(element: AnyElement, indentation: Indentation?) {
        self.element = element
        self.indentation = indentation
    }

    func add(_ attribute: AnyAttribute) {
        if let existingIndex = attributeIndexes[attribute.name] {
            if attribute.replaceExisting {
                attributes[existingIndex].value = attribute.value
            } else if let newValue = attribute.nonEmptyValue {
                if let existingValue = attributes[existingIndex].nonEmptyValue {
                    attributes[existingIndex].value = existingValue + " " + newValue
                } else {
                    attributes[existingIndex].value = newValue
                }
            }
        } else {
            attributeIndexes[attribute.name] = attributes.count
            attributes.append(attribute)
        }
    }

    func add(_ text: String, isPlainText: Bool) {
        if !isPlainText, indentation != nil {
            body.append("\n")
        }

        body.append(text)
    }

    func flush() -> String {
        guard !element.name.isEmpty else { return body }

        let whitespace = indentation?.string ?? ""
        let padding = element.paddingCharacter.map(String.init) ?? ""
        var openingTag = "\(whitespace)<\(padding)\(element.name)"

        for attribute in attributes {
            let string = attribute.render()

            if !string.isEmpty {
                openingTag.append(" " + string)
            }
        }

        let openingTagSuffix = padding + ">"

        switch element.closingMode {
        case .standard,
             .selfClosing where containsChildElements:
            var string = openingTag + openingTagSuffix + body

            if indentation != nil && containsChildElements {
                string.append("\n\(whitespace)")
            }

            return string + "</\(element.name)>"
        case .neverClosed:
            return openingTag + openingTagSuffix + body
        case .selfClosing:
            return openingTag + "/" + openingTagSuffix
        }
    }
}
