/**
*  Plot
*  Copyright (c) John Sundell 2021
*  MIT license, see LICENSE file for details
*/

import Foundation

/// Type representing a component that's directly based on an HTML element.
/// You typically don't have to use this type directly. Instead, Plot ships
/// with a number of type aliases that provide easier access to specialized
/// versions of this type, such as `Div`, `Header`, `Article`, and so on.
/// See the `ElementDefinitions` namespace enum for a list of all such aliases.
public struct ElementComponent<Definition: ElementDefinition>: ComponentContainer {
    @ComponentBuilder public var content: ContentProvider

    public init(@ComponentBuilder content: @escaping ContentProvider) {
        self.content = content
    }

    public var body: Component {
        Definition.wrapper(.component(content()))
    }
}
