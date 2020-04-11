//
//  SVGCGFloat.swift
//  Plot
//
//  Created by Klaus Kneupner on 10/04/2020.
//

import Foundation


extension Double {
    func asString(decimals: Int = 2) -> String {
        return String(format: "%.\(decimals)f", self)
    }
}

extension CGFloat {
    func asString(decimals: Int = 2) -> String {
        return Double(self).asString(decimals: decimals)
    }
}


extension NSPoint {
    func svg(adjustY: Double) -> String {
        let newY = adjustY - Double(self.y)
        return "\(x.asString()) \(newY.asString())"
    }
}
