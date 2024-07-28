//
//  InjectedValuesContainer.swift
//
//
//  Created by Eng.Omar Elsayed on 28/07/2024.
//

import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct InjectedValuesContainer: MemberAttributeMacro {
  public static func expansion(
    of node: AttributeSyntax,
    attachedTo declaration: some DeclGroupSyntax,
    providingAttributesFor member: some DeclSyntaxProtocol,
    in context: some MacroExpansionContext
  ) throws -> [AttributeSyntax] {
    guard let varDecl = member.as(VariableDeclSyntax.self) else { return [] }
    guard let bind = varDecl.bindings.first else { return [] }
    guard bind.pattern.as(IdentifierPatternSyntax.self)?.identifier.text != "current" else { return [] }
    
    return ["@Inject"]
  }
}
