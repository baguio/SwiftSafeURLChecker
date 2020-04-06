import Foundation
import ConsoleKit
import SourceKittenFramework
import Files

struct WatchCommand: Command {
    static let name = "scan"
    
    struct Signature: CommandSignature {
        @Argument(name: "path")
        var path: String
    }
    
    var help: String {
        "Scan files for safe URL declarations"
    }
    
    func run(using context: CommandContext, signature: Signature) throws {
        let sourceDirectory = try Folder(path: signature.path)
        let sourceFiles = sourceDirectory.files.recursive
            .includingHidden
            .filter { "swift" == $0.extension?.lowercased() }
        
        let violations = try sourceFiles.compactMap {
            SourceKittenFramework.File(path: $0.path)
        }.flatMap {
            try Checker.check($0)
        }
        
        context.console.print(Violation.generateReport(for: violations))
    }
}

//public extension URL {
//    init (safeString: StringLiteralType) {
//        self.init(string: safeString)!
//    }
//}
