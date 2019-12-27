/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

internal extension String {
    func escaped() -> String {
        var pendingAmpersandString: String?

        func flushPendingAmpersandString(
            withSuffix suffix: String? = nil,
            resettingTo newValue: String? = nil
        ) -> String {
            let pending = pendingAmpersandString
            pendingAmpersandString = newValue
            return pending.map { "&amp;\($0)\(suffix ?? "")" } ?? suffix ?? ""
        }

        return String(flatMap { character -> String in
            switch character {
            case "<":
                return flushPendingAmpersandString(withSuffix: "&lt;")
            case ">":
                return flushPendingAmpersandString(withSuffix: "&gt;")
            case "&":
                return flushPendingAmpersandString(resettingTo: "")
            case ";":
                let pending = pendingAmpersandString.map { "&\($0);" }
                pendingAmpersandString = nil
                return pending ?? ";"
            case "#" where pendingAmpersandString?.isEmpty == true:
                pendingAmpersandString = "#"
                return ""
            default:
                if let pending = pendingAmpersandString {
                    guard character.isLetter || character.isNumber else {
                        return flushPendingAmpersandString(withSuffix: String(character))
                    }

                    pendingAmpersandString = "\(pending)\(character)"
                    return ""
                }

                return "\(character)"
            }
        }) + flushPendingAmpersandString()
    }
}
