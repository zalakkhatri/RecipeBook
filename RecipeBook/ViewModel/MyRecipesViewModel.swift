//
//  MyRecipesViewModel.swift
//  RecipeBook
//
//  Created by Zalak Khatri on 4/8/24.
//

import SwiftUI

class MyRecipesViewModel: ObservableObject {
    @Published var addingRecipe = false
    @Published var selectedImageData: Data? = nil
    
    var myRecipes: [Recipe] {
          get {
              if let data = UserDefaults.standard.data(forKey: Constants.UserDefaultKey.myRecipes) {
                  do {
                      // Create JSON Decoder
                      let decoder = JSONDecoder()

                      // Decode Note
                      let recipes = try decoder.decode([Recipe].self, from: data)

                      return recipes
                  } catch {
                      print("Unable to Decode Recipe list (\(error))")
                  }
              }
              return []
          }
      }
    
    /**
     This function adds a recipe in a user default
     */
    func addNewRecipe(title: String, ingredients: [Int: String], instructions: String, imageData: Data?) {
        var newIngrediats = [String: String]()
        for (key, value) in ingredients {
            newIngrediats["\(key)"] = value
        }
        var newRecipes = myRecipes
        newRecipes.append(Recipe(id: UUID().uuidString, title: title, ingredients: newIngrediats, instructions: instructions, image: nil, imageData: imageData))
        
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()
            // Encode Note
            let data = try encoder.encode(newRecipes)
            // Write/Set Data
            UserDefaults.standard.set(data, forKey: Constants.UserDefaultKey.myRecipes)
        } catch {
            print("Unable to Encode recipe list (\(error))")
        }
    }
    
    /**
     This fucntion delets a recipe by recipe id from user defaults
     */
    func deleteSavedRecipe(recipe: Recipe) {
        var existingRecipe = myRecipes
        let recipes = existingRecipe.filter({ $0.id == recipe.id })
        if recipes.count == 0 {
            return
        }
        existingRecipe.removeAll(where: { $0.id == recipe.id })
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Encode Note
            let data = try encoder.encode(existingRecipe)

            // Write/Set Data
            UserDefaults.standard.set(data, forKey: Constants.UserDefaultKey.myRecipes)

        } catch {
            print("Unable to Encode recipe list (\(error))")
        }
    }
}
