//
//  MyMacroPlugin.swift
//  
//
//  Created by Eng.Omar Elsayed on 28/07/2024.
//

import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

@main
struct MyMacroPlugin: CompilerPlugin {
  let providingMacros: [Macro.Type] = [
    InjectMacro.self,
    InjectedValuesContainer.self
  ]
}
