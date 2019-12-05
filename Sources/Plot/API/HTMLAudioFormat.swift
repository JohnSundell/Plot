/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Foundation

/// Enum that defines various audio formats supported by most browsers.
public enum HTMLAudioFormat: String, Codable {
    case mp3 = "mpeg"
    case wav
    case ogg
}
