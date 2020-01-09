/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Foundation

public enum HTTPMethod: String, RawRepresentable {
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
    case options = "OPTIONS"
    case patch = "PATCH"
}
