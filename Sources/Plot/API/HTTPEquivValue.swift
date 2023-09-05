//
//  File.swift
//  
//
//  Created by Klaus Kneupner on 13/05/2023.
//

import Foundation

/// The http-equiv attribute is used within the <meta> tag, part of the <head> part of HTML
/// /// see for example: https://www.w3schools.com/tags/att_meta_http_equiv.asp
///
public enum HTTP_Equiv_Value {
    /// Specifies a content policy for the document.
    case contentSecurityPolicy
    /// Specifies the character encoding for the document./
    case contentType
    /// Specified the preferred style sheet to use./
    case defaultStyle
    /// Defines a time interval for the document to refresh itself./
    case refresh
    
    public var value: String {
        switch self {
            case .contentSecurityPolicy: return "content-security-policy"
            case .contentType:  return "content-type"
            case .defaultStyle: return "default-style"
            case .refresh:      return "refresh"
        }
    }
}
