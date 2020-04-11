//
//  SVGDataTypes.swift
//  Plot
//
//  Created by Klaus Kneupner on 11/04/2020.
//

import Foundation


public enum LengthUnits : String, CaseIterable {
    case none = ""
    case percent = "%"
    case pixels = "px"
    case inches = "In"
    case centimeters = "cm"
    case millimeters = "mm"
    case points = "pt"
    case picas = "pc"
    case fontSize = "em"
    case fontSmallCapSize = "ex"
    case fontCharacterUnitSize = "ch"
    case fontRootSize = "rem"
}

public struct SVGLength {
    public let value: Double
    public let unit: LengthUnits
    init (value: Double, unit: LengthUnits = .none) {
        self.value = value
        self.unit = unit
    }
}

extension SVGLength : ExpressibleByFloatLiteral {
    public typealias FloatLiteralType = Double
    
    public init(floatLiteral value: Double) {
        self.init(value: value)
    }
}

extension SVGLength : ExpressibleByIntegerLiteral {
    public typealias IntegerLiteralType = Int
    public init(integerLiteral value: Self.IntegerLiteralType) {
        self.init(value: Double(value))
    }
}

extension SVGLength : ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    
    public init(stringLiteral value: Self.StringLiteralType) {
        for unit in LengthUnits.allCases {
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

