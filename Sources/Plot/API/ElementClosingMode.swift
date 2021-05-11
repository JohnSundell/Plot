/**
*  Plot
*  Copyright (c) John Sundell 2021
*  MIT license, see LICENSE file for details
*/

import Foundation

/// Enum defining how a given element should be closed.
public enum ElementClosingMode {
    /// The standard (default) closing mode, which creates a pair of opening
    /// and closing tags, for example `<html></html>`.
    case standard
    /// For elements that are never closed, for example the leading declaration
    /// tags found at the top of XML documents.
    case neverClosed
    /// For elements that close themselves, for example `<img src="..."/>`.
    case selfClosing
}
