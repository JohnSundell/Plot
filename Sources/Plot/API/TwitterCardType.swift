/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

/// Enum defining various types of cards that can be used to
/// represent a link when it's shared on Twitter.
public enum TwitterCardType: String {
    case summary
    case summaryLargeImage = "summary_large_image"
    case app
    case player
}
