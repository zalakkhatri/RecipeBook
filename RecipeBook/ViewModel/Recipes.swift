//
//  Recipe.swift
//  RecipeBook
//
//  Created by Zalak Khatri on 4/4/24.
//

import Foundation
import SwiftUI

struct Recipes: Codable {
    let s: Int
    let d: [Recipe]
    let t: Int
    let p: P
}

struct Recipe: Codable {
    let id: String
    let title: String
    let ingredients: [String: String]
    let instructions: String
    let image: String?
    let imageData: Data?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "Title"
        case ingredients = "Ingredients"
        case instructions = "Instructions"
        case image = "Image"
        case imageData
    }
}

// MARK: - P
struct P: Codable {
    let limitstart: Int
    let limit: Int
    let total: Int
    let pagesStart: Int
    let pagesStop: Int
    let pagesCurrent: Int
    let pagesTotal: Int
}

enum Screen {
    case searchRecipe
    case savedRecipe
    case myRecipe
}
