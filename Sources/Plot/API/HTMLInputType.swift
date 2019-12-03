/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Foundation

/// Enum that defines various input types that can be used with the
/// `<input/>` HTML element. For example `.input(.type(.text))`.
public enum HTMLInputType: String {
    case button
    case checkbox
    case color
    case date
    case datetimeLocal = "datetime-local"
    case email
    case file
    case hidden
    case image
    case month
    case number
    case password
    case radio
    case range
    case reset
    case search
    case submit
    case tel
    case text
    case time
    case url
    case week
}
