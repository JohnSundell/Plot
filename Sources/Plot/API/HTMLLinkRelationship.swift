/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Foundation

/// An enum that defines various values for an HTML link's `rel`
/// attribute, which specifies the relationship that the link has
/// to the resource that it's linking to.
public enum HTMLLinkRelationship: String {
    case alternate
    case appleTouchIcon = "apple-touch-icon"
    case author
    case canonical
    case dnsPrefetch = "dns-prefetch"
    case help
    case icon
    case license
    case manifest
    case maskIcon = "mask-icon"
    case next
    case pingback
    case preconnect
    case prefetch
    case preload
    case prerender
    case prev
    case search
    case shortcutIcon = "shortcut icon"
    case stylesheet
}
