//
//  SavedRecipesView.swift
//  RecipeBook
//
//  Created by Zalak Khatri on 4/8/24.
//

import SwiftUI

struct SavedRecipesView: View {
    @EnvironmentObject private var viewModel: SearchRecipeViewModel
    @State var recipes: [Recipe] = []
    
    var body: some View {
        NavigationStack {
            HStack {
                if viewModel.savedRecipes.count > 0 {
                    Text("Total \(viewModel.savedRecipes.count) saved recipes found.")
                }
                Spacer()
            }.padding(.horizontal, 16)
            
            List(recipes, id: \.id) { recipe in
                NavigationLink {
                    RecipeDetailView(recipe: recipe)
                } label: {
                    VStack {
                        RecipeImageDetailView(recipe: recipe, screen: .savedRecipe)
                    }
                }
            }
            .onAppear(perform: {
                recipes.removeAll()
                recipes.append(contentsOf: viewModel.savedRecipes)
            })
            .listStyle(.plain)
            .navigationBarTitle("Saved Recipes", displayMode: .inline)
        }
        
    }
}

#Preview {
    SavedRecipesView()
        .environmentObject(SearchRecipeViewModel())
}
