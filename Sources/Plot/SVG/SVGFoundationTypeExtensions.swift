//
//  SVGCGFloat.swift
//  Plot
//
//  Created by Klaus Kneupner on 10/04/2020.
//

import Foundation


public extension Double {
    func asString(decimals: Int = 2) -> String {
        return String(format: "%.\(decimals)f", self)
    }
}

public extension CGFloat {
    func asString(decimals: Int = 2) -> String {
        return Double(self).asString(decimals: decimals)
    }
}


public extension NSPoint {
    func svg(adjustY: Double) -> String {
        let newY = adjustY - Double(self.y)
        return "\(x.asString()) \(newY.asString())"
    }
}

enum HasEndingResult {
    case no
    case remaining(String)
}

extension String {
    func hasEnding(_ ending: String) -> HasEndingResult {
        if let range = self.range(of: ending) {
            return .remaining(String(self.prefix(upTo: range.lowerBound)).trim())
        }
        return .no
    }
    
    public func trim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
}
