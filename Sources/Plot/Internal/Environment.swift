/**
*  Plot
*  Copyright (c) John Sundell 2021
*  MIT license, see LICENSE file for details
*/

internal struct Environment {
    private var values = [String : Any]()

    subscript<T>(key: EnvironmentKey<T>) -> T? {
        get { values["\(key.identifier)"] as? T }
        set { values["\(key.identifier)"] = newValue }
    }
}

extension Environment {
    final class Reference {
        var value: Environment?
    }

    struct Override {
        private let closure: (inout Environment) -> Void

        init<T>(key: EnvironmentKey<T>, value: T) {
            closure = { $0[key] = value }
        }

        func apply(to environment: inout Environment) {
            closure(&environment)
        }
    }
}
