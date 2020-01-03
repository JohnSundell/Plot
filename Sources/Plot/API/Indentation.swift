/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Foundation

/// A representation of a kind of indentation at a given level.
public struct Indentation: Codable, Equatable {
    /// The kind of the indentation (see `Kind`).
    public var kind: Kind
    /// The level of the indentation (0 = root).
    public var level = 0

    /// Initialize an instance for a given kind of indentation.
    public init(kind: Kind) {
        self.kind = kind
    }
}

public extension Indentation {
    /// Enum defining various kinds of indentation that a document
    /// can be rendered using.
    enum Kind: Equatable {
        /// Each level should be indented by a given number of tabs.
        case tabs(Int)
        /// Each level should be indented by a given number of spaces.
        case spaces(Int)
    }
}

internal extension Indentation {
    func indented() -> Indentation {
        var indentation = self
        indentation.level += 1
        return indentation
    }
}

extension Indentation: CustomStringConvertible {
    public var string: String { description }

    public var description: String {
        String(repeating: kind.description, count: level)
    }
}

extension Indentation.Kind: CustomStringConvertible {
    public var description: String {
        switch self {
        case .tabs(let count):
            return String(repeating: "\t", count: count)
        case .spaces(let count):
            return String(repeating: " ", count: count)
        }
    }
}

extension Indentation.Kind: Codable {
    private enum CodingKeys: CodingKey {
        case kind
        case count
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let kind = try container.decode(String.self, forKey: .kind)
        let count = try container.decode(Int.self, forKey: .count)

        switch kind {
        case "tabs":
            self = .tabs(count)
        case "spaces":
            self = .spaces(count)
        default:
            throw DecodingError.dataCorruptedError(
                forKey: CodingKeys.kind,
                in: container,
                debugDescription: "'\(kind)' is not an indentation kind"
            )
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .tabs(let count):
            try container.encode("tabs", forKey: .kind)
            try container.encode(count, forKey: .count)
        case .spaces(let count):
            try container.encode("spaces", forKey: .kind)
            try container.encode(count, forKey: .count)
        }
    }
}
