//
//  RecipeImageDetailView.swift
//  RecipeBook
//
//  Created by Zalak Khatri on 4/10/24.
//

import SwiftUI

struct RecipeImageDetailView: View {
    var recipe: Recipe
    var screen: Screen
    @State var isSaved = false
    @State var isAnnimate = false
    @EnvironmentObject var viewModel: SearchRecipeViewModel
    
    var body: some View {
        HStack {
            VStack {
                if let image = recipe.image {
                    AsyncImage(url: URL(string: "https:\(image)"))
                        .frame(maxWidth: 170, maxHeight: 110)
                        .clipShape(Rectangle())
                } else {
                    Image(systemName: "photo")
                        .frame(maxWidth: 170, maxHeight: 110)
                        .clipShape(Rectangle())
                        .background(.gray)
                }
            }        
            .cornerRadius(CGFloat(10))
            .shadow(radius: 10, x: 5, y: 5)
            VStack {
                Text(recipe.title)
                    .multilineTextAlignment(.leading)
                    .frame(alignment: .trailing)
                    .padding(.leading, 8)
                Spacer()
            }
            if screen == .searchRecipe {
                VStack {
                    Button() {
                        withAnimation(.easeInOut (duration: 2)) {
                            isAnnimate.toggle()
                            let _ = Task {
                                try await Task.sleep(nanoseconds: 2_000_000_000)
                                if isSaved {
                                    viewModel.toggleDeleteRecipe(recipe: recipe)
                                } else {
                                    viewModel.toggleSaveRecipe(recipe: recipe)
                                }
                            }
                        }
                    } label: {
                        Image(systemName: isSaved != isAnnimate ? "bookmark.fill" : "bookmark")
                            .foregroundColor(isSaved != isAnnimate ? Color.green : Color.red)
                            .padding(.top, 5)
                    }
                    .buttonStyle(.borderless)
                    Spacer()
                }.padding(.trailing, 16)
            }
        }
        .frame(height: 120)
        .onAppear(perform: {
            if let _ = viewModel.savedRecipes.first(where: { $0.id == recipe.id }) {
               isSaved = true
            }
        })
    }
}

#Preview {
    RecipeImageDetailView(recipe: Recipe(id: "1213", title: "title", ingredients: ["1" : "1"], instructions: "instructions", image: "", imageData: nil), screen: .searchRecipe)
        .environmentObject(SearchRecipeViewModel())
}
