/**
*  Plot
*  Copyright (c) John Sundell 2021
*  MIT license, see LICENSE file for details
*/

internal protocol AnyElement {
    var name: String { get }
    var closingMode: ElementClosingMode { get }
    var paddingCharacter: Character? { get }
}
