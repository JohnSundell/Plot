//
//  SVGDataTypes.swift
//  Plot
//
//  Created by Klaus Kneupner on 11/04/2020.
//

import Foundation

public protocol QuantityUnits : CaseIterable {
    var rawValue: String {get}
}


public struct Quantity<Units : QuantityUnits> {
    public let value: Double
    public let unit: Units?
    public init (value: Double, unit: Units? = nil) {
        self.value = value
        self.unit = unit
    }
    public func asString(decimals: Int = 2) -> String {
        if let u = unit {
            return value.asString(decimals: decimals) + u.rawValue
        }
        return value.asString(decimals: decimals)
    }
}

extension Quantity : ExpressibleByFloatLiteral {
    public typealias FloatLiteralType = Double
    
    public init(floatLiteral value: Double) {
        self.init(value: value)
    }
}

extension Quantity : ExpressibleByIntegerLiteral {
    public typealias IntegerLiteralType = Int
    public init(integerLiteral value: Self.IntegerLiteralType) {
        self.init(value: Double(value))
    }
}

extension Quantity : ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    
    public init(stringLiteral value: Self.StringLiteralType) {
        for unit in Units.allCases {
            switch value.hasEnding(unit.rawValue) {
            case .no: continue
            case .remaining(let number):
                if let d = Double(number) {
                    self.init(value: d, unit: unit)
                    return
                }
            }
        }
        if let d = Double(value) {
            self.init(value: d)
            return
        }
        assert(false)
        self.init(value: 0)
    }
}


