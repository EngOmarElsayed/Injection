//
//  MyLibDiagnostic.swift
//
//
//  Created by Eng.Omar Elsayed on 28/07/2024.
//

import Foundation
import SwiftDiagnostics

enum MyLibDiagnostic: String, DiagnosticMessage {
  case notAVarVariable
  case mustContainDefaultValue
  case provideName
  case valueIsOptional
  
  var message: String {
    switch self {
    case .notAVarVariable:
      "@Inject should be applied to `var` variable"
    case .mustContainDefaultValue:
      "variable must contain default value"
    case .provideName:
      "provide a name for the variable"
    case .valueIsOptional:
      "@Inject can't be applied to Optional"
    }
  }
  
  var severity: DiagnosticSeverity { .error }
  var diagnosticID: MessageID { .init(domain: "Injection", id: rawValue) }
}
