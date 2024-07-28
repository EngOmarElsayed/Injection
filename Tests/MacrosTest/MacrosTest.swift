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

import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import Macros
import XCTest

fileprivate let testMacros: [String: Macro.Type] = [
  "Inject" : InjectMacro.self,
  "InjectedValuesContainer": InjectedValuesContainer.self
]

final class MacrosTest: XCTestCase {
  
  func test_InjectedValuesContainer_memberAttribute() {
    assertMacroExpansion(
      """
      @InjectedValuesContainer public struct InjectedValues {
        var current = ""
        var test: Test = test()
      }
      """,
      expandedSource: """
      public struct InjectedValues {
        var current = ""
        var test: Test {
            get {
                              Self [TestInjectionKey.self]
                   }
                   set {
                     Self[TestInjectionKey.self] = newValue
                   }
        }

        private struct TestInjectionKey: InjectionKey {
           static var currentValue: Test = test()
        }
      }
      """,
      macros: testMacros
    )
  }
  
  func test_InjectMacro_Accessor() {
    assertMacroExpansion(
      """
@Inject var test: Test = Test()
""",
      expandedSource: """
 var test: Test {
     get {
                       Self [TestInjectionKey.self]
            }
            set {
              Self[TestInjectionKey.self] = newValue
            }
 }
 
 private struct TestInjectionKey: InjectionKey {
    static var currentValue: Test = Test()
 }
 """,
      macros: testMacros
    )
  }
}
