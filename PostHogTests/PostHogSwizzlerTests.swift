//
//  PostHogSwizzlerTests.swift
//  PostHog
//
//  Created by Jules on 21/02/2025.
//

import Foundation
@testable import PostHog
import Testing

class PHSwizzleTestBaseClass: NSObject {
    @objc dynamic func originalMethod() -> String {
        return "original"
    }
}

class PHSwizzleTestSubClass: PHSwizzleTestBaseClass {
    // Inherits originalMethod
}

extension PHSwizzleTestSubClass {
    @objc dynamic func swizzledMethod() -> String {
        return "swizzled"
    }
}

@Suite("PostHogSwizzlerTests")
struct PostHogSwizzlerTests {

    @Test("swizzling subclass does not affect superclass")
    func testSwizzle() {
        let base = PHSwizzleTestBaseClass()
        let sub = PHSwizzleTestSubClass()

        #expect(base.originalMethod() == "original")
        #expect(sub.originalMethod() == "original")

        swizzle(forClass: PHSwizzleTestSubClass.self,
                original: #selector(PHSwizzleTestSubClass.originalMethod),
                new: #selector(PHSwizzleTestSubClass.swizzledMethod))

        #expect(sub.originalMethod() == "swizzled")

        // This check ensures that the superclass implementation remains intact.
        // With unsafe swizzling (method_exchangeImplementations on inherited method),
        // the superclass's method implementation is swapped, causing base.originalMethod() to return "swizzled".
        #expect(base.originalMethod() == "original")
    }
}
