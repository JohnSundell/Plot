//
//  HTMLFormMethod.swift
//  
//
//  Created by Michael Critz on 12/19/19.
//

import Foundation

/// Describes the form action’s `method`
public enum HTMLFormMethod: String, CustomStringConvertible {
    /// CORS-safelisted methods
    case get, head, post
    
    /// Acceptable methods
    case delete, put, options, patch
    
    // Forbidden `method`s should never be included: `CONNECT`, `TRACE`, and `TRACK`.
    
    public var description: String {
        get {
            return self.rawValue.uppercased()
        }
    }
}
