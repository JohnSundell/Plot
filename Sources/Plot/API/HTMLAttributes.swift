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

    /// Assign whether operating system level spell checking should be enabled.
    /// - parameter isEnabled: Whether spell checking should be enabled.
    static func spellcheck(_ isEnabled: Bool) -> Attribute {
        Attribute(name: "spellcheck", value: String(isEnabled))
    }

    /// Specify a title for the element.
    /// - parameter title: The title to assign to the element.
    static func title(_ title: String) -> Attribute {
        Attribute(name: "title", value: title)
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

    /// Assign whether operating system level spell checking should be enabled.
    /// - parameter isEnabled: Whether spell checking should be enabled.
    static func spellcheck(_ isEnabled: Bool) -> Node {
        .attribute(named: "spellcheck", value: String(isEnabled))
    }

    /// Specify a title for the element.
    /// - parameter title: The title to assign to the element.
    static func title(_ title: String) -> Node {
        .attribute(named: "title", value: title)
    }

    /// Assign whether the element should be hidden.
    /// - parameter isHidden: Whether the element should be hidden or not.
    static func hidden(_ isHidden: Bool) -> Node {
        isHidden ? .attribute(named: "hidden") : .empty
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

// MARK: - Interactive elements

public extension Node where Context == HTML.DetailsContext {
    /// Assign whether the details element is opened/expanded.
    /// - parameter isOpen: Whether the element should be displayed as open.
    static func open(_ isOpen: Bool) -> Node {
        isOpen ? .attribute(named: "open") : .empty
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

public extension Attribute where Context == HTML.PictureSourceContext {
    /// Assign a string describing a set of sources, using the `srcset` attribute.
    /// - parameter set: The set of sources that this element should point to.
    static func srcset(_ set: String) -> Attribute {
        Attribute(name: "srcset", value: set)
    }

    /// Assign a media query that determines whether this source should be used.
    /// - parameter query: The media query that the browser should evaluate.
    static func media(_ query: String) -> Attribute {
        Attribute(name: "media", value: query)
    }

    /// Assign a string describing the MIME type, using the `type` attribute.
    /// - parameter type: The type (MIME type) for this element.
    static func type(_ type: String) -> Attribute {
        Attribute(name: "type", value: type)
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
    
    /// Add the `novalidate` attribute to the form, which
    /// disables any native browser validation on the form.
    /// - parameter isOn: Whether validation should be disabled.
    static func novalidate(_ isOn: Bool = true) -> Node {
        isOn ? .attribute(named: "novalidate") : .empty
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
    
    /// Assign a placeholder to the input field.
    /// - parameter placeholder: The placeholder to assign.
    static func placeholder(_ placeholder: String) -> Attribute {
        Attribute(name: "placeholder", value: placeholder)
    }

    /// Assign whether the element should have autocomplete turned on or off.
    /// - parameter isOn: Whether autocomplete should be turned on.
    static func autocomplete(_ isOn: Bool) -> Attribute {
        Attribute(name: "autocomplete", value: isOn ? "on" : "off")
    }

    /// Assign whether the element is required before submitting the form.
    /// - parameter isRequired: Whether the element is required.
    static func required(_ isRequired: Bool) -> Attribute {
        isRequired ? Attribute(name: "required", value: nil, ignoreIfValueIsEmpty: false) : .empty
    }
    
    /// Assign whether the element should be autofocused when the page loads.
    /// - parameter isOn: Whether autofocus should be turned on.
    static func autofocus(_ isOn: Bool) -> Attribute {
        isOn ? Attribute(name: "autofocus", value: nil, ignoreIfValueIsEmpty: false) : .empty
    }

    /// Assign whether the element should be read-only.
    /// - parameter isReadonly: Whether the input is read-only.
    static func readonly(_ isReadonly: Bool) -> Attribute {
        isReadonly ? Attribute(name: "readonly", value: nil, ignoreIfValueIsEmpty: false) : .empty
    }

    /// Assign whether the element should be disabled.
    /// - parameter isDisabled: Whether the input is disabled.
    static func disabled(_ isDisabled: Bool) -> Attribute {
        isDisabled ? Attribute(name: "disabled", value: nil, ignoreIfValueIsEmpty: false) : .empty
    }

    /// Assign whether the element should allow the selection of multiple values.
    /// - parameter isMultiple: Whether multiple values are allowed.
    static func multiple(_ isEnabled: Bool) -> Attribute {
        isEnabled ? Attribute(name: "multiple", value: nil, ignoreIfValueIsEmpty: false) : .empty
    }

    /// Assign whether a checkbox or radio input element has an active state.
    /// - parameter isChecked: Whether the element has an active state.
    static func checked(_ isChecked: Bool) -> Attribute {
        isChecked ? Attribute(name: "checked", value: nil, ignoreIfValueIsEmpty: false) : .empty
    }
}

public extension Node where Context == HTML.ButtonContext {
    /// Assign a button type to the element.
    /// - parameter type: The button type to assign.
    static func type(_ type: HTMLButtonType) -> Node {
        .attribute(named: "type", value: type.rawValue)
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
    
    /// Assign a placeholder to the text area.
    /// - parameter placeholder: The placeholder to assign.
    static func placeholder(_ placeholder: String) -> Node {
        .attribute(named: "placeholder", value: placeholder)
    }

    /// Assign whether the element is required before submitting the form.
    /// - parameter isRequired: Whether the element is required.
    static func required(_ isRequired: Bool) -> Node {
        isRequired ? .attribute(named: "required") : .empty
    }
    
    /// Assign whether the element should be autofocused when the page loads.
    /// - parameter isOn: Whether autofocus should be turned on.
    static func autofocus(_ isOn: Bool) -> Node {
        isOn ? .attribute(named: "autofocus") : .empty
    }

    /// Assign whether the element should be read-only.
    /// - parameter isReadonly: Whether the input is read-only.
    static func readonly(_ isReadonly: Bool) -> Node {
        isReadonly ? .attribute(named: "readonly") : .empty
    }

    /// Assign whether the element should be disabled.
    /// - parameter isDisabled: Whether the input is disabled.
    static func disabled(_ isDisabled: Bool) -> Node {
        isDisabled ? .attribute(named: "disabled") : .empty
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

    /// Assign a label to the given option.
    /// - parameter label: The user displayed value of the option
    static func label(_ label: String) -> Attribute {
        Attribute(name: "label", value: label, ignoreIfValueIsEmpty: false)
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
        allow ? Attribute(name: "allowfullscreen", value: nil, ignoreIfValueIsEmpty: false) : .empty
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
    
    /// Assign an accessibility attribute to an element,
    /// which removes an element from the accessibility tree
    /// - parameter isHidden: Whether the element is hidden or not
    static func ariaHidden(_ isHidden: Bool) -> Node {
        .attribute(named: "aria-hidden", value: isHidden ? "true" : "false")
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

// MARK: - Scripts

public extension Node where Context == HTML.ScriptContext {
    /// Assign that the element's script should be loaded in `async` mode.
    static func async() -> Node {
        .attribute(named: "async", value: nil, ignoreIfValueIsEmpty: false)
    }
    
    /// Assign that the element's script should be loaded in `defer` mode.
    static func `defer`() -> Node {
        .attribute(named: "defer", value: nil, ignoreIfValueIsEmpty: false)
    }
}

// MARK: - Javascript

public extension Node where Context: HTML.BodyContext {
    /// Add a script to execute when the user clicks the current element.
    /// - parameter script: The script to execute when the user clicks on the node.
    ///   Usually prefixed with `javascript:`.
    static func onclick(_ script: String) -> Node {
        .attribute(named: "onclick", value: script)
    }
}
