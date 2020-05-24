//
//  File.swift
//  
//
//  Created by everis on 4/6/20.
//

import Foundation

struct Violation {
    let location: Location
    let ruleName: String
    let ruleDescription: String
}

extension Violation {
    var generateReport : String {
        // {full_path_to_file}:{line}:{character}: {error,warning}: {content}
        return [
            "\(location.fileOrDefault):\(location.lineOrDefault):\(location.characterOrDefault): ",
            "error: ",
            "\(ruleName) Violation: ",
            ruleDescription
        ].joined()
    }
}

extension Violation {
    static func generateReport(for violations: [Violation]) -> String {
        violations.map(\.generateReport).joined(separator: "\n")
    }
}

extension Location {
    var fileOrDefault: String {
        file ?? "<nopath>"
    }
    var lineOrDefault: Int {
        line ?? 1
    }
    var characterOrDefault: Int {
        character ?? 1
    }
}
