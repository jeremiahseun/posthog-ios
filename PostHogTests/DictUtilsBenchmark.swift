//
//  DictUtilsBenchmark.swift
//  PostHogTests
//
//  Created for PostHog Performance Optimization
//

import XCTest
@testable import PostHog

class DictUtilsBenchmark: XCTestCase {

    func testPerformanceSanitizeDictionary() {
        // Create a large dictionary with many dates to amplify the effect
        var dict: [String: Any] = [:]
        for i in 0..<1000 {
            dict["date_\(i)"] = Date()
            dict["string_\(i)"] = "some string"
            dict["int_\(i)"] = i
        }

        // Measure performance
        measure {
            // We run this multiple times to get a stable measurement
            for _ in 0..<10 {
                _ = sanitizeDictionary(dict)
            }
        }
    }
}
