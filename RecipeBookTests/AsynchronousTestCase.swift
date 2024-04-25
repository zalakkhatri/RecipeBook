//
//  AsynchronousTestCAse.swift
//  RecipeBookTests
//
//  Created by Zalak Khatri on 4/13/24.
//
import SwiftUI
import XCTest
@testable import RecipeBook

final class AsynchronousTestCase: XCTestCase {
    let timeout: TimeInterval = 1
    var expectation: XCTestExpectation!
    
    override func setUp() {
        expectation = expectation(description: "Server responds in reasonable time")
    }
    
    func test_noServerResponse() {
        let url = URL(string: "recipe")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            defer { self.expectation.fulfill() }
            XCTAssertNil(data)
            XCTAssertNil(response)
            XCTAssertNotNil(error)
        }
        .resume()
        waitForExpectations(timeout: timeout)
    }
}
