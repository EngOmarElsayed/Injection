//Copyright (c) 2024 Eng.Omar Elsayed
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.

import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftDiagnostics

//MARK: -  Private Methods
public struct InjectMacro {
  private static func addError(_ error: MyLibDiagnostic, _ node: AttributeSyntax, context: some MacroExpansionContext) {
    let error = Diagnostic(node: node, message: error)
    context.diagnose(error)
  }
  
  private static func checkVariable(for varDec: DeclSyntaxProtocol, _ node: AttributeSyntax, context: some MacroExpansionContext) -> (id: TokenSyntax?, bind: PatternBindingSyntax?) {
    guard let varDecl = varDec.as(VariableDeclSyntax.self), varDecl.bindingSpecifier.text == "var" else {
      addError(.notAVarVariable, node, context: context)
      return (nil, nil)
    }
    
    guard let binding = varDecl.bindings.first else { return (nil, nil) }
    
    guard let _ = binding.initializer else {
      addError(.mustContainDefaultValue, node, context: context)
      return (nil, nil)
    }
    
    if let isOptionalType = binding.typeAnnotation?.type.is(OptionalTypeSyntax.self), isOptionalType {
      addError(.valueIsOptional, node, context: context)
      return (nil, nil)
    }
    
    guard var identifier = binding.pattern.as(IdentifierPatternSyntax.self)?.identifier else {
      addError(.provideName, node, context: context)
      return (nil, nil)
    }
    
    identifier = .identifier(identifier.text.upperCaseFirstLetter())
    return (identifier, binding)
  }
}

//MARK: -  AccessorMacro
extension InjectMacro: AccessorMacro {
  public static func expansion(
    of node: AttributeSyntax,
    providingAccessorsOf declaration: some DeclSyntaxProtocol,
    in context: some MacroExpansionContext
  ) throws -> [AccessorDeclSyntax] {
    guard let (identifier,_) = checkVariable(for: declaration, node, context: context) as? (TokenSyntax, PatternBindingSyntax) else { return [] }
    
    return ["""
           get {
             Self[\(identifier)InjectionKey.self]
           }
           set {
             Self[\(identifier)InjectionKey.self] = newValue
           }
    """]
  }
}

//MARK: -  PeerMacro
extension InjectMacro: PeerMacro {
  public static func expansion(
    of node: AttributeSyntax,
    providingPeersOf declaration: some DeclSyntaxProtocol,
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    guard var (identifier, binding) = checkVariable(for: declaration, node, context: context) as? (TokenSyntax, PatternBindingSyntax) else { return [] }
    binding.pattern = PatternSyntax(IdentifierPatternSyntax(identifier: .identifier("currentValue")))
    
    return [
    """
 private struct \(identifier)InjectionKey: InjectionKey {
    static var \(binding)
 }
 """
    ]
  }
}
