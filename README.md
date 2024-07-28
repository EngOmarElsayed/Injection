# Injection
![example workflow](https://github.com/EngOmarElsayed/Injection/actions/workflows/swift.yml/badge.svg)
![GitHub License](https://img.shields.io/github/license/EngOmarElsayed/Injection)
[![SPM compatible](https://img.shields.io/badge/SPM-compatible-4BC51D.svg?style=flat)](#swift-package-manager)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FEngOmarElsayed%2FInjection%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/EngOmarElsayed/Injection)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FEngOmarElsayed%2FInjection%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/EngOmarElsayed/Injection)

## Table of Contents
1. [Introduction](#introduction)
2. [How to use](#section-1)
3. [Testing](#section-2)
4. [Resources](#resources)
5. [Author](#conclusion)

## Introduction <a name="introduction"></a>
This package was developed to address one of the most challenging topics in the Swift community: dependency injection. I often found it difficult to grasp this concept and implement it effectively. Through extensive research, I discovered a straightforward method inspired by the `@Environment` property wrapper in SwiftUI. A defining feature of this package is its simplicity, making it easily understandable for anyoney.

Key issues addressed by this package include:
 * Simplifying the process of mocking data for tests.
 * Maintaining readability by adhering closely to Swift’s standard APIs.
 * Ensuring compile-time safety to prevent hidden crashes, so if the application builds, all dependencies are correctly configured.
 * Avoiding large initializers caused by dependency injection.
 * Relieving the AppDelegate from being the central point for defining all shared instances.
 * Minimizing potential learning curves.
 * Eliminating the need for force unwrapping.
 * Allowing the definition of standard dependencies without exposing private or internal types within packages.

first start by adding the pacakge to your code base as follow:

```swift
.package(url: "https://github.com/EngOmarElsayed/Injection", from: "1.3"),
```

Alternatively, navigate to the top section labeled 'Files' and click on 'Add Package Dependency':

<img width="300" alt="Screenshot 2024-03-15 at 3 33 08 AM" src="https://github.com/EngOmarElsayed/SwiftUserDefaults/assets/125718818/835a99dc-6ed3-4e35-9ed2-4458ec6935de">


## How to use <a name="section-1"></a>
Let's say we have a protocol called `MotorBike` (why motorBike because I love them 😍😅) that contains a funcation called `move`:

```swift
protocol MotorBike {
    func move() -> Int
}
```
And there is a struct called `Ducati` that conforms to `MotorBike`:

```swift
struct Ducati: MotorBike {
   func move() -> Int {
       return 5
   }
}
```

At this point we want to inject this object to another object using dependency injection design pattern to do so, 
the first step is to make an extension `InjectedValues` and add the new property that containes the object instance :

```swift
@InjecteValues extension InjectedValues {
  var ducatiProvider: MotorBike = Ducati()
}
```
and that's it...simple right 😉. The `InjecteValues` macro expand the code to this at compile time:

```swift
@InjecteValues extension InjectedValues {
  var ducatiProvider: MotorBike = Ducati()

//Expanded Code
private struct DucatiKey: InjectionKey {
   static var currentValue: MotorBike = Ducati()
}
    var ducatiProvider: MotorBike {
       get { Self[DucatiKey.self] }
       set { Self[DucatiKey.self] = newValue }
   }
}
```

To be able to use it, you will just write this where ever you need it:

```swift
struct Garage {
@Injected(\.ducatiProvider) var ducati: MotorBike
}
```

And that's it, simple right 🚀.

> [!NOTE]  
> When ever you call the `@Injected` you will have the same instance throught the life cycle of the app.
> To prevent any side effects and weird outcomes from happening due to inconsistent dependency references.

> [!NOTE]  
> Plus you can easily change the instance by writing:
> 
> ```swift
> let garage = Garage()
> garage.ducati = Ducati()
> //OR
> InjectedValues[\.ducatiProvider] = Ducati()
> ```
> Using the `InjectedValues` static subscript also affects already injected properties.


## Testing <a name="section-2"></a>
Testing your code is more easier than you think, you will just have to change the injected properties with a mock one using `InjectedValues` static subscript, like so:

```swift
final class MotorBikeTests: XCTestCase {
    override func setUp() {
        InjectedValues[\.ducatiProvider] = DuctiMock()
    }
    
    func test() {
        let garge = Garage()
        
        let result = garge.move()
        
        XCTAssertEqual(10, result)
    }
}

class DuctiMock: MotorBike {
    func move() -> Int {
        return 10
    }
}
```
that's it for how to test your injected properties. Easey right ? 😎

## Resources <a name="resources"></a>
Some helpful links for you:
* https://developer.apple.com/documentation/swiftui/environment
* https://www.avanderlee.com/swift/dependency-injection/
* https://www.avanderlee.com/swift/property-wrappers/

## Author <a name="conclusion"></a>
This pacakge was created by [Eng.Omar Elsayed](https://www.linkedin.com/in/engomarelsayed/) to help the iOS comuntity and make there life easir. To contact me email me at eng.omar.elsayed@hotmail.com
