/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

internal protocol NodeConvertible {
    func asNode() -> AnyNode
}

internal extension Array where Element: NodeConvertible {
    func asNodes() -> [AnyNode] {
        map { $0.asNode() }
    }
}
