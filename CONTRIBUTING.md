# Plot Contribution Guide

Welcome to the *Plot Contribution Guide* — a document that aims to give you all the information you need to contribute to the Plot project. Thanks for your interest in contributing to this project, and hopefully this document will help make it as smooth and enjoyable as possible to do so.

## Bugs, feature requests and support

Plot doesn’t use GitHub issues, so all form of support — whether that’s asking a question, reporting a bug, or discussing a feature request — takes place in Pull Requests.

The idea behind this workflow is to encourage more people using Plot to dive into the source code and familiarize themselves with how it works, in order to better be able to *self-service* on bugs and issues — hopefully leading to a better and smoother experience for everyone involved.

### I found a bug, how do I report it?

If you find a bug, for example an element or attribute that doesn’t render correctly, here’s the recommended workflow:

1. Come up with the simplest code possible that reproduces the issue in isolation.
2. Write a test case using the code that reproduces the issue. See [Plot’s existing test suite](Tests/PlotTests) for inspiration on how to get started, or [this article](https://www.swiftbysundell.com/basics/unit-testing) if you want to learn some of the basics of unit testing in Swift.
3. Either fix the bug yourself, or simply submit your failing test as a Pull Request, and we can work on a solution together.

While doing the above does require a bit of extra work for the person who found the bug, it gives us as a community a very nice starting point for fixing issues — hopefully leading to quicker fixes and a more constructive workflow.

### I have an idea for a feature request

First of all, that’s awesome! Your ideas on how to make Plot better and more powerful are super welcome. Here’s the recommended workflow for feature requests:

1. Do some prototyping and come up with a sample implementation of your idea or feature request. Note that this doesn’t have to be a fully working, complete implementation, just something that illustrates the feature/idea and how it could be added to Plot.
2. Submit your sample implementation as a Pull Request. Use the description field to write down why you think the feature should be added and some initial discussion points.
3. Together we’ll discuss the feature and your sample implementation, and either accept it as-is, or use it as a starting point for a new implementation, or decide that the idea is not worth implementing as this time.

### I have a question that the documentation doesn’t yet answer

With Plot, the goal is to end up with state of the art documentation that answers most of the questions that both users and developers of the tool might have — and the only way to get there is through continued improvement, with your help. Here’s the recommended workflow for getting your question answered:

1. Start by looking through the code. Chances are high that you’ll be able to answer your own question by reading through the implementation, the tests, and the inline code documentation.
2. If you found out the answer to your question — then don’t stop there. Other people will probably ask themselves the same question at some point, so let’s improve the documentation! Find an appropriate place where your question could’ve been answered by clearer documentation or a better structure (for example this document, or inline in the code), and add the documentation you wish would’ve been there. If you didn’t manage to find an answer (no worries, we're all always learning), then write down your question as a comment — either in the code or in one of the Markdown documents.
3. Submit your new documentation or your comment as a Pull Request, and we'll work on improving the documentation together.

## Project structure

Plot’s code is structured into two main folders — `API` and `Internal`. Any code that has a public-facing API should go into `API`, and purely internal types and functions should go into `Internal`. Note that you shouldn’t split a type up into two files, but rather find one place for it depending on if it has *any* public-facing components.

For each document type, for example `HTML`, there are several key files in which APIs are defined:

- The main document file, `HTML`, defines the format itself as well as all of its `Context` types.
- The elements file, `HTMLElements`, defines all DSL APIs for constructing elements within a document.
- The attributes file, `HTMLAttributes`, defines all DSL APIs for constructing attributes for elements of that format.
- Finally, the components file, `HTMLComponents`, defines higher-level components that are compositions of elements and attributes.

*The same structure is also used for all other document formats — `XML`, `RSS`, `PodcastFeed`, and `SiteMap`.*

## Unit testing

Plot has 100% unit testing coverage, and the goal is to keep it that way. All changes to Plot should be fully covered with tests, both to make sure that the new implementation works as expected, and to ensure that it keeps working as the code base is being iterated on.

If you’re new to unit testing and want to learn more about it, then Swift by Sundell has [lots of articles on the topic](https://www.swiftbysundell.com/tags/unit-testing), starting with [this Basics article](https://www.swiftbysundell.com/basics/unit-testing).

## Adding a new node type

If you’ve encountered an element or attribute that’s missing from Plot’s DSL, then feel free to add it. Here’s how to do that:

1. Start by finding the file in which your new API should be added. The above [project structure section](#project-structure) should help you identify the file that’d be the most appropriate. For example, HTML elements should be defined within `HTMLElements.swift`, and attributes within `HTMLAttributes.swift`.
2. Either add your new API to an existing `Node` extension, or create a new one constrained to the type of `Context` that your element or attribute belongs in. For example, if it’s an attribute for an `<a>` HTML element, then it should be defined in the `Node` extension `where Context == HTML.AnchorContext`.
3. Write a test that verifies that your new API is working. See the above [unit testing section](#unit-testing) for more information.
4. Submit your new API and your test as a Pull Request.
5. Your Pull Request will be reviewed by a maintainer as soon as possible.

## Conclusion

Hopefully this document has given you an introduction to how Plot works, both in terms of its recommended project workflow and its structure. Feel free to submit Pull Requests to improve this document, and hope you’ll have a nice experience contributing to Plot.