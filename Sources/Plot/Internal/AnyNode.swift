/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

internal protocol AnyNode {
    func render(into renderer: ElementRenderer)
}

extension Node: AnyNode {
    func render(into renderer: ElementRenderer) {
        switch self {
        case .element(let element):
            renderer.addElement(element)
        case .attribute(let attribute):
            renderer.addAttribute(attribute)
        case .text(let text):
            renderer.addText(text)
        case .raw(let text):
            renderer.addRawText(text)
        case .group(let nodes):
            nodes.forEach { $0.render(into: renderer) }
        case .empty:
            break
        }
    }
}
