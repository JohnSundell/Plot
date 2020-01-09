/**
*  Plot
*  Copyright (c) John Sundell 2020
*  MIT license, see LICENSE file for details
*/

import Foundation

/// Enum describing various content types that can be used
/// with an HTML `<form>` element. The default is `urlEncoded`.
public enum HTMLFormContentType: String, RawRepresentable {
    /// The form should be URL-encoded when submitted.
    case urlEncoded = "application/x-www-form-urlencoded"
    /// The form should be submitted as multipart data.
    case multipartData = "multipart/form-data"
    /// The form should be submitted as plain text.
    case plainText = "text/plain"
}
