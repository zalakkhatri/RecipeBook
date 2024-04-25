//
//  MyRecipeImageDetailView.swift
//  RecipeBook
//
//  Created by Zalak Khatri on 4/13/24.
//

import SwiftUI

struct MyRecipeImageDetailView: View {
    var recipe: Recipe
    @State var isAnnimate = false
    
    var body: some View {
        HStack {
            VStack {
                if let image = recipe.image {
                    AsyncImage(url: URL(string: "https:\(image)"))
                        .frame(maxWidth: 170, maxHeight: 110)
                        .clipShape(Rectangle())
                } else if let imageData = recipe.imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 170, height: 110)
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
            }
        }
        .frame(height: 120)
        .padding(.bottom, 8)
    }
}


#Preview {
    MyRecipeImageDetailView(recipe: Recipe(id: "12212", title: "title", ingredients: ["1" : "1"], instructions: "instructions", image: "image", imageData: nil), isAnnimate: true)
}
