/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

internal extension String {
    func escaped() -> String {
        String(flatMap { character -> String in
            switch character {
            case "<":
                return "&lt;"
            case ">":
                return "&gt;"
            case "&":
                return "&amp;"
            default:
                return "\(character)"
            }
        })
    }
}
