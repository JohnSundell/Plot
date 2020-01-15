/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

// MARK: - Generic attributes

public extension Attribute where Context: HTMLContext {
    /// Assign an ID to the current element.
    /// - parameter id: The ID to assign.
    static func id(_ id: String) -> Attribute {
        Attribute(name: "id", value: id)
    }

    /// Assign a class name to the current element. May also be a list of
    /// space-separated class names.
    /// - parameter class: The class or list of classes to assign.
    static func `class`(_ className: String) -> Attribute {
        Attribute(name: "class", value: className)
    }

    /// Add a `data-` attribute to the current element.
    /// - parameter name: The name of the attribute to add. The name will
    ///   be prefixed with `data-`.
    /// - parameter value: The attribute's string value.
    static func data(named name: String, value: String) -> Attribute {
        Attribute(name: "data-\(name)", value: value)
    }
}

public extension Node where Context: HTMLContext {
    /// Assign an ID to the current element.
    /// - parameter id: The ID to assign.
    static func id(_ id: String) -> Node {
        .attribute(named: "id", value: id)
    }

    /// Assign a class name to the current element. May also be a list of
    /// space-separated class names.
    /// - parameter class: The class or list of classes to assign.
    static func `class`(_ className: String) -> Node {
        .attribute(named: "class", value: className)
    }

    /// Add a `data-` attribute to the current element.
    /// - parameter name: The name of the attribute to add. The name will
    ///   be prefixed with `data-`.
    /// - parameter value: The attribute's string value.
    static func data(named name: String, value: String) -> Node {
        .attribute(named: "data-\(name)", value: value)
    }
}

public extension Attribute where Context: HTMLNamableContext {
    /// Assign a name to the element.
    /// - parameter name: The name to assign.
    static func name(_ name: String) -> Attribute {
        Attribute(name: "name", value: name)
    }
}

public extension Node where Context: HTMLNamableContext {
    /// Assign a name to the element.
    /// - parameter name: The name to assign.
    static func name(_ name: String) -> Node {
        .attribute(named: "name", value: name)
    }
}

public extension Attribute where Context: HTMLTypeContext {
    /// Assign a type string to this element.
    /// - parameter type: The name of the type to assign.
    static func type(_ type: String) -> Attribute {
        Attribute(name: "type", value: type)
    }
}

public extension Attribute where Context: HTMLValueContext {
    /// Assign a string value to the element.
    /// - parameter value: The value to assign.
    static func value(_ value: String) -> Attribute {
        Attribute(name: "value", value: value)
    }
}

public extension Node where Context: HTMLValueContext {
    /// Assign a string value to the element.
    /// - parameter value: The value to assign.
    static func value(_ value: String) -> Node {
        .attribute(named: "value", value: value)
    }
}

// MARK: - Document

public extension Node where Context == HTML.DocumentContext {
    /// Specify the language of the HTML document's content.
    /// - parameter language: The language to specify.
    static func lang(_ language: Language) -> Node {
        .attribute(named: "lang", value: language.rawValue)
    }
}

// MARK: - Links

public extension Attribute where Context == HTML.LinkContext {
    /// Assign a relationship to the link. See `HTMLLinkRelationship` for more info.
    /// - parameter relationship: The relationship to assign.
    static func rel(_ relationship: HTMLLinkRelationship) -> Attribute {
        Attribute(name: "rel", value: relationship.rawValue)
    }

    /// Assign an `hreflang` attribute to this element.
    /// - parameter language: The language to assign.
    static func hreflang(_ language: Language) -> Attribute {
        Attribute(name: "hreflang", value: language.rawValue)
    }

    /// Assign an icon sizes string to this element.
    /// - parameter sizes: The icon sizes string to assign.
    static func sizes(_ sizes: String) -> Attribute {
        Attribute(name: "sizes", value: sizes)
    }

    /// Assign an icon color string to this element.
    /// - parameter color: The icon color string to assign.
    static func color(_ color: String) -> Attribute {
        Attribute(name: "color", value: color)
    }
}

public extension Attribute where Context: HTMLLinkableContext {
    /// Assign a URL to link the element to, using its `href` attribute.
    /// - parameter url: The URL to assign.
    static func href(_ url: URLRepresentable) -> Attribute {
        Attribute(name: "href", value: url.string)
    }
}

public extension Node where Context: HTMLLinkableContext {
    /// Assign a URL to link the element to, using its `href` attribute.
    /// - parameter url: The URL to assign.
    static func href(_ url: URLRepresentable) -> Node {
        .attribute(named: "href", value: url.string)
    }
}

public extension Node where Context == HTML.AnchorContext {
    /// Assign a target to the anchor, specifying how its URL should be opened.
    /// - parameter target: The target to assign. See `HTMLAnchorTarget`.
    static func target(_ target: HTMLAnchorTarget) -> Node {
        .attribute(named: "target", value: target.rawValue)
    }

    /// Assign a relationship to the anchor, using its `rel` attribute.
    /// - parameter relationship: The relationship to assign. See
    ///   `HTMLAnchorRelationship` for more info.
    static func rel(_ relationship: HTMLAnchorRelationship) -> Node {
        .attribute(named: "rel", value: relationship.rawValue)
    }
}

// MARK: - Sources and media

public extension Attribute where Context: HTMLSourceContext {
    /// Assign a source to the element, using its `src` attribute.
    /// - parameter url: The source URL to assign.
    static func src(_ url: URLRepresentable) -> Attribute {
        Attribute(name: "src", value: url.string)
    }
}

public extension Node where Context: HTMLSourceContext {
    /// Assign a source to the element, using its `src` attribute.
    /// - parameter url: The source URL to assign.
    static func src(_ url: URLRepresentable) -> Node {
        .attribute(named: "src", value: url.string)
    }
}

public extension Node where Context: HTMLMediaContext {
    /// Assign whether the element's media controls should be enabled.
    /// - parameter enableControls: Whether controls should be shown.
    static func controls(_ enableControls: Bool) -> Node {
        enableControls ? .attribute(named: "controls") : .empty
    }
}

public extension Attribute where Context == HTML.AudioSourceContext {
    /// Assign a type to this audio source. See `HTMLAudioFormat` for more info.
    /// - parameter format: The audio format to assign.
    static func type(_ format: HTMLAudioFormat) -> Attribute {
        Attribute(name: "type", value: "audio/" + format.rawValue)
    }
}

public extension Attribute where Context == HTML.VideoSourceContext {
    /// Assign a type to this video source. See `HTMLVideoFormat` for more info.
    /// - parameter format: The video format to assign.
    static func type(_ format: HTMLVideoFormat) -> Attribute {
        Attribute(name: "type", value: "video/" + format.rawValue)
    }
}

// MARK: - Forms, input and options

public extension Node where Context == HTML.FormContext {
    /// Assign a URL that this form should be sent to when submitted.
    /// - parameter url: The action URL that the form should be sent to.
    static func action(_ url: URLRepresentable) -> Node {
        .attribute(named: "action", value: url.string)
    }
    
    /// Assign a specific content type to the form.
    /// - Parameter type: The content type to assign.
    static func enctype(_ type: HTMLFormContentType) -> Node {
        .attribute(named: "enctype", value: type.rawValue)
    }
    
    /// Assign a specific HTTP request method that the form should
    /// be submitted using.
    /// - Parameter method: The HTTP request method to use.
    static func method(_ method: HTMLFormMethod) -> Node {
        .attribute(named: "method", value: method.rawValue)
    }
}

public extension Node where Context == HTML.LabelContext {
    /// Assign which input control that this label is for.
    /// - parameter target: The target input control's name.
    static func `for`(_ target: String) -> Node {
        .attribute(named: "for", value: target)
    }
}

public extension Attribute where Context == HTML.InputContext {
    /// Assign an input type to the element.
    /// - parameter type: The input type to assign.
    static func type(_ type: HTMLInputType) -> Attribute {
        Attribute(name: "type", value: type.rawValue)
    }

    /// Assign whether the element should have autocomplete turned on or off.
    /// - parameter isOn: Whether autocomplete should be turned on.
    static func autocomplete(_ isOn: Bool) -> Attribute {
        Attribute(name: "autocomplete", value: isOn ? "on" : "off")
    }

    /// Assign whether the element is required before submitting the form.
    /// - parameter isRequired: Whether the element is required.
    static func required(_ isRequired: Bool) -> Attribute {
        isRequired ? Attribute(name: "required", value: "true") : .empty
    }
    
    /// Assign whether the element should be autofocused when the page loads.
    /// - parameter isOn: Whether autofocus should be turned on.
    static func autofocus(_ isOn: Bool) -> Attribute {
        isOn ? Attribute(name: "autofocus", value: "true") : .empty
    }
}

public extension Node where Context == HTML.TextAreaContext {
    /// Specify the number of columns that the text area should contain.
    /// - parameter columns: The number of columns to specify.
    static func cols(_ columns: Int) -> Node {
        .attribute(named: "cols", value: String(columns))
    }

    /// Specify the number of text rows that should be visible within the text area.
    /// - parameter rows: The number of rows to specify.
    static func rows(_ rows: Int) -> Node {
        .attribute(named: "rows", value: String(rows))
    }
    
    /// Assign whether the element is required before submitting the form.
    /// - parameter isRequired: Whether the element is required.
    static func required(_ isRequired: Bool) -> Node {
        isRequired ? .attribute(named: "required", value: "true") : .empty
    }
    
    /// Assign whether the element should be autofocused when the page loads.
    /// - parameter isOn: Whether autofocus should be turned on.
    static func autofocus(_ isOn: Bool) -> Node {
        isOn ? .attribute(named: "autofocus", value: "true") : .empty
    }
}

public extension Attribute where Context == HTML.OptionContext {
    /// Specify whether the option should be initially selected.
    /// - parameter isSelected: Whether the option should be selected.
    static func isSelected(_ isSelected: Bool) -> Attribute {
        guard isSelected else { return .empty }

        return Attribute(
            name: "selected",
            value: nil,
            ignoreIfValueIsEmpty: false
        )
    }
}

// MARK: - Layout and styling

public extension Attribute where Context: HTMLDimensionContext {
    /// Assign a given width to the element.
    /// - parameter width: The width to assign.
    static func width(_ width: Int) -> Attribute {
        Attribute(name: "width", value: String(width))
    }

    /// Assign a given height to the element
    /// - parameter height: The height to assign.
    static func height(_ height: Int) -> Attribute {
        Attribute(name: "height", value: String(height))
    }
}

public extension Node where Context: HTMLStylableContext {
    /// Assign inline CSS to the element, using its `style` attribute.
    /// - parameter css: The CSS string to assign.
    static func style(_ css: String) -> Node {
        .attribute(named: "style", value: css)
    }
}

// MARK: - Metadata

public extension Attribute where Context == HTML.MetaContext {
    /// Assign an encoding to the element, using its `charset` attribute.
    /// - parameter encoding: The encoding to assign. See `DocumentEncoding`.
    static func charset(_ encoding: DocumentEncoding) -> Attribute {
        Attribute(name: "charset", value: encoding.rawValue)
    }

    /// Assign a content string to the element.
    /// - parameter content: The content value to assign.
    static func content(_ content: String) -> Attribute {
        Attribute(name: "content", value: content)
    }
}

// MARK: - iFrames

public extension Attribute where Context == HTML.IFrameContext {
    /// Assign whether the iframe should display a border or not.
    /// - parameter isOn: Whether a border should be displayed.
    static func frameborder(_ isOn: Bool) -> Attribute {
        Attribute(name: "frameborder", value: isOn ? "1" : "0")
    }

    /// Assign what sort of features that the iframe should be allowed to access.
    /// - parameter features: A list of feature names to allow.
    static func allow(_ features: String...) -> Attribute {
        Attribute(name: "allow", value: features.joined(separator: "; "))
    }

    /// Assign whether to grant the iframe full screen capabilities.
    /// - parameter allow: Whether the iframe should be allowed to go full screen.
    static func allowfullscreen(_ allow: Bool) -> Attribute {
        Attribute(name: "allowfullscreen", value: String(allow))
    }
}

// MARK: - Images

public extension Attribute where Context == HTML.ImageContext {
    /// Assign an alternative text to the image. This is important both for
    /// accessibility, and in case the referenced image can't be rendered.
    /// - parameter text: The alternative text to use.
    static func alt(_ text: String) -> Attribute {
        Attribute(name: "alt", value: text)
    }
}

// MARK: - Accessibility

public extension Node where Context: HTML.BodyContext {
    /// Assign an accessibility label to the element, which is used by
    /// assistive technologies to get a text representation of it.
    /// - parameter label: The label to assign.
    static func ariaLabel(_ label: String) -> Node {
        .attribute(named: "aria-label", value: label)
    }
    
    /// Assign an accessibility attribute to an element,
    /// to establish a parent -> child relationship
    /// - parameter child: The child to assign to the parent
    static func ariaControls(_ child: String) -> Node {
        .attribute(named: "aria-controls", value: child)
    }
    
    /// Assign an accessibility attribute to an element,
    /// which describes whether the element is expanded or not
    /// - parameter isExpanded: Whether the element is expanded or not
    static func ariaExpanded(_ isExpanded: Bool) -> Node {
        .attribute(named: "aria-expanded", value: isExpanded ? "true" : "false")
    }
}

// MARK: - Subresource Integrity

public extension Attribute where Context: HTMLIntegrityContext {
    /// Assign a subresouce integrity hash to the element, using its `integrity` attribute.
    /// - parameter hash: base64-encoded cryptographic hash
    static func integrity(_ hash: String) -> Attribute {
        Attribute(name: "integrity", value: hash)
    }
}

public extension Node where Context: HTMLIntegrityContext {
    /// Assign a subresouce integrity hash to the element, using its `integrity` attribute.
    /// - parameter hash: base64-encoded cryptographic hash
    static func integrity(_ hash: String) -> Node {
        .attribute(named: "integrity", value: hash)
    }
}

// MARK: - Other, element-specific attributes

public extension Node where Context == HTML.AbbreviationContext {
    /// Specify the abbreviation's full text through its `title` attribute.
    /// - parameter title: The title to assign.
    static func title(_ title: String) -> Node {
        .attribute(named: "title", value: title)
    }
}
