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

import XCTest
import Injection

final class InjectionTests: XCTestCase {
  @Injected(\.networkProvider) fileprivate var network: Network
  
  func test_propertyWrapper_getRightInstance() {
    let expected = "Succeed"
    
    let result = network.updateRequest()
    
    XCTAssertEqual(expected, result)
  }
  
  func test_propertyWrapper_getRightInstance_AfterChangingInjectedValues() {
    let expected = "Mock"
    
    InjectedValues[\.networkProvider] = NetworkProviderMock()
    let result = network.updateRequest()
    
    XCTAssertEqual(expected, result)
  }
  
  func test_propertyWrapper_getRightInstance_AfterChangingPrperty() {
    let expected = "Mock"
    
    network = NetworkProviderMock()
    let result = network.updateRequest()
    
    XCTAssertEqual(expected, result)
  }
}

//MARK: -  DependencyExample

fileprivate protocol Network {
  func updateRequest() -> String
}

fileprivate struct NetworkProvider: Network {
  func updateRequest() -> String {
    return "Succeed"
  }
}

fileprivate struct NetworkProviderMock: Network {
  func updateRequest() -> String {
    return "Mock"
  }
}

@InjecteValues extension InjectedValues {
  fileprivate var networkProvider: Network = NetworkProvider()
  fileprivate var test: String = "Test"
}
