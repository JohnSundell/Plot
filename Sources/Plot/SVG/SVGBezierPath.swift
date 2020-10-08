//
//  SVGBezierPath.swift
//  Plot
//
//  Created by Klaus Kneupner on 09/04/2020.
//

import Foundation
import AppKit.NSBezierPath


extension NSBezierPath {
    public func svgString(adjustY: Double) -> String {
        var result = ""
        let points = UnsafeMutablePointer<NSPoint>.allocate(capacity: 3)
        let numElements = self.elementCount

        if numElements > 0 {
            for index in 0..<numElements {
                let pathType = self.element(at: index, associatedPoints: points)

                switch pathType {
                case .moveTo :
                    result += "M\(points[0].svg(adjustY: adjustY))"
                case .lineTo :
                    result += "L\(points[0].svg(adjustY: adjustY)) "
                case .curveTo :
                    result += "C\(points[0].svg(adjustY: adjustY)) \(points[1].svg(adjustY: adjustY)) \(points[2].svg(adjustY: adjustY)) "
                case .closePath:
                    result += "Z"
                @unknown default:
                    fatalError()
                }
            }
        }

        points.deallocate()
        return result
    }
}
