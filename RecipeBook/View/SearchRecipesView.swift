//
//  SearchRecipes.swift
//  RecipeBook
//
//  Created by Zalak Khatri on 4/4/24.
//

import SwiftUI

struct SearchRecipesView: View {
    @EnvironmentObject private var viewModel: SearchRecipeViewModel
    @State private var query = ""
    @State private var showQueryField = false
    @State private var fetchObjectsTask: Task<Void, Error>?
    @State private var showingAlert = false
    
    var body: some View {
        NavigationStack {
            HStack {
                if !query.isEmpty {
                    Text("You searched for '\(query)'")
                }
                Spacer()
            }.padding(.horizontal, 16)

            HStack {
                if !viewModel.searchStart, viewModel.recipes.count == 0 {
                    Text("Result is none.")
                } else if viewModel.recipes.count > 0 {
                    Text("Total \(viewModel.recipes.count) recipes found.")
                } else {
                    Text("Search for recipes for example \"Pizza\"")
                }
                Spacer()
            }.padding(.horizontal, 16)
            
            List(viewModel.recipes, id: \.id) { recipe in
                NavigationLink {
                    RecipeDetailView(recipe: recipe)
                } label: {
                    VStack {
                        RecipeImageDetailView(recipe: recipe, screen: .searchRecipe)
                            .environmentObject(viewModel)
                    }
                }
            }
            .listStyle(.plain)
            .navigationBarTitle("Home", displayMode: .inline)
            .alert(
                "Search the recipe",
                isPresented: $showQueryField,
                actions: {
                    TextField("Search the recipe", text: $query)
                    Button("Search") {
                        fetchObjectsTask?.cancel()
                        viewModel.searchStart = true
                        fetchObjectsTask = Task {
                            do {
                                viewModel.recipes = []
                              //  try await viewModel.fetchRecipes(for: query)
                                // Uncomment below and comment above line to test with json stored in recipes.json
                               try await viewModel.loadAPIDetailsFormAppBundle()
                            } catch {
                                viewModel.searchStart = false
                                showingAlert = true
                            }
                        }
                    }
                })
            .overlay {
                if viewModel.recipes.isEmpty && !query.isEmpty && viewModel.searchStart {
                    ProgressView()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    SearchRecipeButtonView(query: $query, showQueryField: $showQueryField)
                }
            }
            .alert("Error occured while fetching results", isPresented: $showingAlert) {
                 Button("OK", role: .cancel) { }
             }
        }
    }
}

struct SearchRecipeButtonView: View {
    @Binding var query: String
    @Binding var showQueryField: Bool
    
    var body: some View {
        HStack {
            Button(action: {
                query = ""
                showQueryField = true
            }, label: {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .imageScale(.medium)
                    Text("Search Recipe")
                }
            })
            Spacer()
        }.padding(.trailing, 8)
    }
}

#Preview {
    SearchRecipesView()
        .environmentObject(SearchRecipeViewModel())
}
