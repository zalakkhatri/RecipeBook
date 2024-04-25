//
//  MyRecipesTests.swift
//  RecipeBookTests
//
//  Created by Zalak Khatri on 4/19/24.
//

import XCTest
@testable import RecipeBook

final class MyRecipesTests: XCTestCase {

    var viewModel: MyRecipesViewModel!

    override func setUp() {
        viewModel = MyRecipesViewModel()
    }

    func testAddNewRecipe() {
        viewModel.addNewRecipe(title: "Test recipe", ingredients: [1 : "2 tomatos"], instructions: "Instructions", imageData: nil)

        XCTAssertNotNil(viewModel.myRecipes)
        XCTAssertTrue(viewModel.myRecipes.count > 0)

        let filteredRecipe = viewModel.myRecipes.filter({ $0.title == "Test recipe" })
        XCTAssertNotNil(filteredRecipe)
    }

    func testDeleteSavedRecipe() {

        viewModel.addNewRecipe(title: "Test recipe", ingredients: [1 : "2 tomatos"], instructions: "Instructions", imageData: nil)

        XCTAssertNotNil(viewModel.myRecipes)
        XCTAssertTrue(viewModel.myRecipes.count > 0)

        let filteredRecipe = viewModel.myRecipes.filter({ $0.title == "Test recipe" })
        XCTAssertNotNil(filteredRecipe)
        if let recipe = filteredRecipe.first {
            viewModel.deleteSavedRecipe(recipe: recipe)
            sleep(2)

            let filteredRecipe1 = viewModel.myRecipes.filter({ $0.id == recipe.id })
            XCTAssertTrue(filteredRecipe1.count == 0)
        }
    }
}
