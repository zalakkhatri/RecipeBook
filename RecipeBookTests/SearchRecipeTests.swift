//
//  SearchRecipeTests.swift
//  RecipeBookTests
//
//  Created by Zalak Khatri on 4/4/24.
//

import XCTest
@testable import RecipeBook

final class SearchRecipeTests: XCTestCase {
    var viewModel: SearchRecipeViewModel!

    override func setUp() {
        viewModel = SearchRecipeViewModel()
    }


    func testLoadAPIDetailsFormAppBundle() async {
        do {
            try await viewModel.loadAPIDetailsFormAppBundle()

            XCTAssertNotNil(viewModel.recipes)
            XCTAssertEqual(viewModel.recipes.count, 19)
            XCTAssertFalse(viewModel.searchStart)

        } catch {
            
        }
    }

    func testToggleSaveRecipe() {
        let recipe = Recipe(id: "123456", title: "Test recipe", ingredients: ["1" : "2 tomatos"], instructions: "Instructions", image: nil, imageData: nil)

        XCTAssertNotNil(recipe)
        viewModel.toggleSaveRecipe(recipe: recipe)

        XCTAssertNotNil(viewModel.savedRecipes)
        XCTAssertTrue(viewModel.savedRecipes.count > 0)

        let filteredRecipe = viewModel.savedRecipes.filter({ $0.id == "123456" })
        XCTAssertNotNil(filteredRecipe)
    }

    func testToggleDeleteRecipe() {
        let recipe = Recipe(id: "123456", title: "Test recipe", ingredients: ["1" : "2 tomatos"], instructions: "Instructions", image: nil, imageData: nil)

        let filteredRecipe = viewModel.savedRecipes.filter({ $0.id == "123456" })
        XCTAssertNotNil(filteredRecipe)

        viewModel.toggleDeleteRecipe(recipe: recipe)
        sleep(2)

        let filteredRecipe1 = viewModel.savedRecipes.filter({ $0.id == "123456" })
        XCTAssertTrue(filteredRecipe1.count == 0)

    }
}
