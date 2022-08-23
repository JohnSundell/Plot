/**
*  Plot
*  Copyright (c) John Sundell 2021
*  MIT license, see LICENSE file for details
*/

import Foundation

/// Property wrapper that can be used to read a value from the environment.
///
/// You can annotate any `Component` property with the `@EnvironmentValue` attribute
/// to have its value be determined by the environment. Environment values are always
/// associated with an `EnvironmentKey`, and are passed downwards through a component/node
/// hierarchy until overridden by another value.
@propertyWrapper public struct EnvironmentValue<Value>: AnyEnvironmentValue {
    /// The underlying value of the wrapped property.
    public var wrappedValue: Value { environment.value?[key] ?? key.defaultValue }

    internal let environment = Environment.Reference()
    private let key: EnvironmentKey<Value>

    /// Initialize an instance of this wrapper with the `EnvironmentKey` that should
    /// be used to determine its property's value.
    /// - parameter key: The environment key to use to read this property's value.
    public init(_ key: EnvironmentKey<Value>) {
        self.key = key
    }
}
