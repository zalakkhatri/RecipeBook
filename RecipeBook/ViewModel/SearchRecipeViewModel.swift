//
//  SearchRecipeViewModel.swift
//  RecipeBook
//
//  Created by Zalak Khatri on 4/4/24.
//

import SwiftUI

public enum MediaError: Error {
  case requestFailed
  case responseDecodingFailed
  case urlCreationFailed
}

class SearchRecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isDownloading = false
    @Published var searchStart = true
    
    private var apiKey: String {
      get {
        // 1
        guard let filePath = Bundle.main.path(forResource: "secureKeys", ofType: "plist") else {
          fatalError("Couldn't find file 'secureKeys.plist'.")
        }
        // 2
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
          fatalError("Couldn't find key 'API_KEY' in 'secureKeys.plist'.")
        }
        return value
      }
    }

    var savedRecipes: [Recipe] {
          get {
              if let data = UserDefaults.standard.data(forKey: Constants.UserDefaultKey.savedRecipes) {
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
    
    func fetchRecipes(for queryTerm: String) async throws {
        guard var urlComponents = URLComponents(string: Constants.Endpoints.baseURLString) else {
            throw MediaError.urlCreationFailed
        }
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: queryTerm)
        ]

        guard let queryURL = urlComponents.url else { throw MediaError.requestFailed }
        var request = URLRequest(url: queryURL)
        request.setValue(apiKey, forHTTPHeaderField: Constants.String.rapidAPIKey)
        request.setValue(Constants.Hosts.searchAPIhost, forHTTPHeaderField: Constants.String.rapidAPIHost)
        request.httpMethod = Constants.String.get

        let (data, response) = try await URLSession.shared.data(for: request)  // 1
        guard
            let response = response as? HTTPURLResponse,
            (200..<300).contains(response.statusCode)
        else {
            print("Error occured while making an API call")
            throw MediaError.requestFailed
        }
        do {  // 2
            let result = try JSONDecoder().decode(Recipes.self, from: data)
            await MainActor.run {
                self.recipes = result.d
                searchStart = false
            }
            print("searchResult: \(result)")
        } catch {
            searchStart = false
            print(error)
            throw MediaError.responseDecodingFailed
        }
    }

  //  Loading json from App bundle
    func loadAPIDetailsFormAppBundle() async throws  {
      guard let apiJSONURL = Bundle.main.url(forResource: "recipes", withExtension: "json") else {
        return
      }
      let decoder = JSONDecoder()
      
      do {
        let apiData = try Data(contentsOf: apiJSONURL)
        let apiInfo = try decoder.decode(Recipes.self, from: apiData)
        await MainActor.run {
            self.recipes = apiInfo.d
            searchStart = false
        }
        print(recipes)
      } catch let error {
          print(error)
          throw MediaError.responseDecodingFailed
      }
    }
    
    /**
            This function saves recipe in a userdefault
     */
    func toggleSaveRecipe(recipe: Recipe) {
        var newRecipes = savedRecipes
        if let _ = newRecipes.first(where: { $0.id == recipe.id }) {
            return
        }
        newRecipes.append(recipe)
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Encode Note
            let data = try encoder.encode(newRecipes)

            // Write/Set Data
            UserDefaults.standard.set(data, forKey: Constants.UserDefaultKey.savedRecipes)

        } catch {
            print("Unable to Encode recipe list (\(error))")
        }
    }
    
    /**
     This function delets recipe by recipe id from user defaults
     */
    func toggleDeleteRecipe(recipe: Recipe) {
        var existingRecipe = savedRecipes
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
            UserDefaults.standard.set(data, forKey: Constants.UserDefaultKey.savedRecipes)

        } catch {
            print("Unable to Encode recipe list (\(error))")
        }
    }
}
