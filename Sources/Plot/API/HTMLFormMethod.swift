//
//  HTMLFormMethod.swift
//  
//
//  Created by Michael Critz on 12/19/19.
//

import Foundation

/// Describes the form action’s `method`
public enum HTMLFormMethod: String, RawRepresentable {
    // CORS-safelisted methods
    /// GET: By REST convention, read a resource.  Requests using GET should only retrieve data.
    case get = "GET"
    /// Like GET, but discared the body. Not a REST convetion.
    case head = "HEAD"
    /// By REST convention, create a resource.
    case post = "POST"
    
    // Acceptable methods
    /// DELETE: by REST convention, delete a resource.
    case delete = "DELETE"
    /// PUT: by REST convention, update a resource by *replacing* the existing resource with the request body.
    case put = "PUT"
    /// OPTIONS: used to describe the communication options for the target resource.
    case options = "OPTIONS"
    /// PATCH: by REST convention, update a resource by *modifing* part of the resouces with the request body.
    case patch = "PATCH"
    
    // NOTE: Accodring the the HTML spec for form these forbidden `method`s should never be included: `CONNECT`, `TRACE`, and `TRACK`.
}
