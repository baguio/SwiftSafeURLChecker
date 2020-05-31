# SafeURLChecker

A CLI tool for validating URLs written in literal Strings in Swift code. This tool is ideal for checks at build time using Xcode or Swift IDEs

## How does it work

This uses [SourceKitten](https://github.com/jpsim/SourceKitten) to analyse Swift code, search for URL inits using the extension `URL(safeURL: String)` available at [SafeURL](https://github.com/baguio/SwiftSafeURL), and check if the native Swift.URL implementation can use the URL specified.  
Also, this tool can report these non-valid URLs to Xcode, by printing a specific pattern at the script phase terminal:

```
{full_path_to_file}:{line}:{character}: {error,warning}: {content}
```

An example of this would be:

```
/User/johndoe/Project/Source/ExampleFile.swift:15:16: error: This is an error description
```
