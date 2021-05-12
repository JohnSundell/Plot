/**
*  Plot
*  Copyright (c) John Sundell 2021
*  MIT license, see LICENSE file for details
*/

internal protocol AnyAttribute {
    var name: String { get }
    var value: String? { get set }
    var replaceExisting: Bool { get }

    func render() -> String
}

extension AnyAttribute {
    var nonEmptyValue: String? {
        value?.isEmpty == false ? value : nil
    }
}
