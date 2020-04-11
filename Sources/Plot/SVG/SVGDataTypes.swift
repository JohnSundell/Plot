//
//  SVGDataTypes.swift
//  Plot
//
//  Created by Klaus Kneupner on 11/04/2020.
//

import Foundation


public enum LengthUnits : String {
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
    public let unit: LengthUnits = .none
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
        
        //How to split best???
        self.init(value: 10)
    }
    
}

