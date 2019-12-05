/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Foundation

/// Enum that defines various video formats supported by most browsers.
public enum HTMLVideoFormat: String, Codable {
    case mp4
    case webM = "webm"
    case ogg
}
