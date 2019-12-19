//
//  HTMLFormMethod.swift
//  
//
//  Created by Michael Critz on 12/19/19.
//

import Foundation

/// Describes the form action’s `method`
public enum HTMLFormMethod: String, CustomStringConvertible {
    // CORS-safelisted methods
    /// GET: By REST convention, read a resource.  Requests using GET should only retrieve data.
    case get
    /// Like GET, but discared the body. Not a REST convetion.
    case head
    /// By REST convention, create a resource.
    case post
    
    // Acceptable methods
    /// DELETE: by REST convention, delete a resource.
    case delete
    /// PUT: by REST convention, update a resource by *replacing* the existing resource with the request body.
    case put
    /// OPTIONS: used to describe the communication options for the target resource.
    case options
    /// PATCH: by REST convention, update a resource by *modifing* part of the resouces with the request body.
    case patch
    
    // Accodring the the HTML spec for form these forbidden `method`s should never be included: `CONNECT`, `TRACE`, and `TRACK`.
    
    public var description: String {
        get {
            return self.rawValue.uppercased()
        }
    }
}
