//
//  File.swift
//  
//
//  Created by everis on 4/4/20.
//

import Foundation
import SourceKittenFramework

class Checker {
    private static let parameterName = "safeString"
    
    private static let unvalidSafeInputRegexes = [
        (rule: #".+(?<!\\)\".+"#, description: "Non-escaped string delimiter mid-string"),
        (rule: #".+(?<!\\)\\\(.+"#, description: "Interpolation")
        ]
    
    static func check(_ file: SourceKittenFramework.File) throws -> [Violation] {
        var violations = [Violation]()
        
        let structure = try SourceKittenFramework.Structure(file: file)
        let skd = SourceKittenDictionary(structure.dictionary)
        let urlDeclarations = skd.flatten().compactMap { "URL" == $0.name ? $0.substructure : nil }
        let urlSafeStringAttributes = urlDeclarations.compactMap { declarationItems -> SourceKittenDictionary? in
            let lookupResults = declarationItems.filter {
                $0.expressionKind == .argument && $0.name == Self.parameterName
            }
            if lookupResults.count > 1 {
                print("More than one attribute found. Ignoring")
            }
            return lookupResults.first
        }
        
        urlSafeStringAttributes.forEach { dict in
            guard let bodyByteRange = dict.bodyByteRange,
                let bodyOffset = dict.bodyOffset,
                let text = file.stringView.substringWithByteRange(bodyByteRange)
                else
            {
                print("Can't find argument value")
                return
            }
            
            let location = Location(file: file, byteOffset: bodyOffset)
            
            Self.unvalidSafeInputRegexes.forEach {
                if text.range(of: $0.rule, options: .regularExpression) != nil {
                    violations.append(
                        Violation(location: location,
                                  ruleName: "URL Format",
                                  ruleDescription: $0.description)
                    )
                }
            }
            if violations.isEmpty, URL(string: text) == nil {
                violations.append(
                    Violation(location: Location(file: file,
                                                 byteOffset: bodyOffset),
                              ruleName: "URL Format",
                              ruleDescription: "Invalid URL")
                )
            }
        }
        
        return violations
    }
}
