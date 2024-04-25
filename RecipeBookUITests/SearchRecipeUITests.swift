//
//  SearchRecipeUITests.swift
//  SearchRecipeUITests
//
//  Created by Zalak Khatri on 4/4/24.
//

import XCTest
import UIKit
@testable import RecipeBook

final class SearchRecipeUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
    }

    func testSearchButton() throws {

        if app.buttons["Next"].exists {
            let nextButton = app.buttons["Next"]
            XCTAssertTrue(nextButton.exists)
            nextButton.tap()
            
            let doneButton = app.buttons["Done"]
            XCTAssertTrue(doneButton.exists)
            doneButton.tap()
        }

        let tabBar = app.tabBars["Tab Bar"]
        XCTAssertTrue(tabBar.exists)
        tabBar.buttons["Home"].tap()

        let text = app.navigationBars["Home"].staticTexts["Search Recipe"]
        XCTAssertTrue(text.exists)
        text.tap()

        let alert = app.alerts["Search the recipe"]
        XCTAssertTrue(alert.exists)
        let innerSearchButton = alert.scrollViews.otherElements.buttons["Search"]
        XCTAssertTrue(innerSearchButton.exists)
        innerSearchButton.tap()

        let myRecipeButton = app.tabBars["Tab Bar"].buttons["My Recipes"]
        XCTAssertTrue(myRecipeButton.exists)
        myRecipeButton.tap()

        let navBar1 = app.navigationBars["My Recipes"]
        XCTAssertTrue(navBar1.exists)
        let text1 = navBar1.staticTexts["Add"]
        XCTAssertTrue(text1.exists)
        text1.tap()

        let cancelButton = app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["Cancel"]
        XCTAssertTrue(cancelButton.exists)
        cancelButton.tap()

    }
}
