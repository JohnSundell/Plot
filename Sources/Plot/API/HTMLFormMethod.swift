/**
*  Plot
*  Copyright (c) John Sundell 2020
*  MIT license, see LICENSE file for details
*/

import Foundation

/// Enum describing various HTTP request methods that can
/// be used when submitting an HTML `<form>`.
public enum HTMLFormMethod: String, RawRepresentable {
    /// Use a `GET` request.
    case get
    /// Use a `POST` request.
    case post
}
