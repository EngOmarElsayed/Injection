# Injection
![example workflow](https://github.com/EngOmarElsayed/Injection/actions/workflows/swift.yml/badge.svg)
![GitHub License](https://img.shields.io/github/license/EngOmarElsayed/Injection)
[![SPM compatible](https://img.shields.io/badge/SPM-compatible-4BC51D.svg?style=flat)](#swift-package-manager)

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


> [!NOTE]  
> You can also store optional values just like that:
> ```swift
> @UserDefaults(key: "previewShown") var previewShown: Bool?
> ```


## Testing <a name="section-2"></a>

## Resources <a name="resources"></a>

## Author <a name="conclusion"></a>
This pacakge was created by [Eng.Omar Elsayed](https://www.linkedin.com/in/engomarelsayed/) to help the iOS comuntity and make there life easir. To contact me email me at eng.omar.elsayed@hotmail.com
