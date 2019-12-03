/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

/// Enum describing all valid values for a site map url's change frequency.
public enum SiteMapChangeFrequency: String {
    case always
    case hourly
    case daily
    case weekly
    case monthly
    case yearly
    case never
}
