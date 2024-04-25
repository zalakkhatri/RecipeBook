//
//  MyRecipeDetailView.swift
//  RecipeBook
//
//  Created by Zalak Khatri on 4/13/24.
//

import SwiftUI

struct MyRecipeDetailView: View {
    var recipe: Recipe
    @EnvironmentObject var myRecipesViewModel: MyRecipesViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            HStack {
                Text(recipe.title)
                    .font(.headline)
                    .frame(alignment: .leading)
                Spacer()
            }
            if let image = recipe.image {
                AsyncImage(url: URL(string: "https:\(image)"))
                    .frame(maxWidth: .infinity, maxHeight: 500, alignment: .center)
                    .padding(.bottom, 8)
            } else if let imageData = recipe.imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 500)
                    .padding(.bottom, 8)
            } else {
                Image(systemName: "photo")
                    .frame(width: 350, height: 270)
                    .clipShape(Rectangle())
                    .background(.gray)
                    .padding(.bottom, 8)
            }
            Divider()
            HStack {
                Text("Ingredients")
                    .font(.headline)
                    .frame(alignment: .leading)
                Spacer()
            }
            ForEach(recipe.ingredients.keys.sorted(), id: \.self) { key in
                if let value = recipe.ingredients[key] {
                    HStack {
                        Text(value)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                }
            }
            Divider()
            HStack {
                Text("Instructions")
                    .font(.headline)
                    .frame(alignment: .leading)
                Spacer()
            }
            Text(recipe.instructions)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
        }
        .padding(.horizontal, 16)
        .navigationBarTitle("", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    myRecipesViewModel.deleteSavedRecipe(recipe: recipe)
                    dismiss()
                }, label: {
                    Text("Delete")
                        .foregroundColor(.red)
                    Image(systemName: "trash")
                        .imageScale(.medium)
                        .foregroundColor(.red)
                })
                
            }
            
        }
    }
}

#Preview {
    MyRecipeDetailView(recipe: Recipe(id: "id", title: "title", ingredients: ["1" : "1"], instructions: "Instruction", image: "Image", imageData: nil))
}
