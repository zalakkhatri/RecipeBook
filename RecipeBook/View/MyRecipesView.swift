//
//  MyRecipesView.swift
//  RecipeBook
//
//  Created by Zalak Khatri on 4/4/24.
//

import SwiftUI

struct MyRecipesView: View {
    @StateObject var myRecipesViewModel = MyRecipesViewModel()
    @State private var recipe = ""
    @State var myRecipes: [Recipe] = []
    
    var body: some View {
        NavigationStack {
            HStack {
                if myRecipes.count > 0 {
                    Text("Total \(myRecipes.count) recipes found.")
                }
                Spacer()
            }.padding(.horizontal, 16)
            
            List(myRecipes, id: \.id) { recipe in
                NavigationLink {
                    MyRecipeDetailView(recipe: recipe)
                        .environmentObject(myRecipesViewModel)
                } label: {
                    VStack {
                        MyRecipeImageDetailView(recipe: recipe)
                    }
                }
            }
            .listStyle(.plain)
            .navigationBarTitle("My Recipes", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        myRecipesViewModel.addingRecipe.toggle()
                    }, label: {
                      Text("Add")
                      Image(systemName: "plus.circle")
                        .imageScale(.medium)
                        .bold()
                    })
                    .fullScreenCover(
                      isPresented: $myRecipesViewModel.addingRecipe,
                      onDismiss: {
                          myRecipes.removeAll()
                          myRecipes.append(contentsOf: myRecipesViewModel.myRecipes)
                      }
                    ) {
                        AddRecipeView()
                            .environmentObject(myRecipesViewModel)
                    }
                }
            }
            .onAppear(perform: {
                myRecipes.removeAll()
                myRecipes.append(contentsOf: myRecipesViewModel.myRecipes)
            })
        }
    }
}

#Preview {
    MyRecipesView()
}
