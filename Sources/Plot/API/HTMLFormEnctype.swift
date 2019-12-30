//
//  HTMLFormEnctype.swift
//  
//
//  Created by Michael Critz on 12/19/19.
//

import Foundation

/// Describes the Media Type (also known as MIME type) of a form that defines the serialization of the form.
/// The actual encoding should be done by the browser / client. This enum merely describes the desired form behavior as HTML.
/// See HTML spec 4.10.21.3
/// https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#text/plain-encoding-algorithm
public enum HTMLFormEnctype: String, RawRepresentable {
    /// All characters are encoded. This is the default behavior of HTML <form> elements.
    case applicationURLEncoded = "application/x-www-form-urlencoded"
    
    /// No characters are encoded. This value is required when you are using forms that have a file, media, images, video, upload control.
    case multipartFormData = "multipart/form-data"
    
    /// Spaces are converted to `+` character, but otherwise characters are not encoded. Used mostly for debugging.
    case textPlain = "text/plain"
}
