//
//  File.swift
//
//
//  Created by everis on 3/28/20.
//

import Foundation
import ConsoleKit

let console: Console = Terminal()
var input = CommandInput(arguments: CommandLine.arguments)
var context = CommandContext(console: console, input: input)

var commands = Commands(enableAutocomplete: true)

commands.use(ScanCommand(), as: ScanCommand.name, isDefault: true)

do {
    let group = commands.group(help: "Interact with your TODOs")
    try console.run(group, input: input)
}
catch {
    console.error("\(error)")
    exit(1)
}
