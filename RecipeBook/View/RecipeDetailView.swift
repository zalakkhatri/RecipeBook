//
//  RecipeDetailView.swift
//  RecipeBook
//
//  Created by Zalak Khatri on 4/4/24.
//

import SwiftUI

struct RecipeDetailView: View {
    var recipe: Recipe
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
            } else {
                Image(systemName: "photo")
                    .frame(maxWidth: .infinity, maxHeight: 500)
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
    }
}

#Preview {
    RecipeDetailView(recipe: Recipe(id: "id", title: "title", ingredients: ["1" : "1"], instructions: "Instruction", image: "Image", imageData: nil))
}
