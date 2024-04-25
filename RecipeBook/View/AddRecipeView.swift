//
//  AddRecipeView.swift
//  RecipeBook
//
//  Created by Zalak Khatri on 4/6/24.
//

import PhotosUI
import SwiftUI
import PhotosUI

struct AddRecipeView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var myRecipesViewModel: MyRecipesViewModel
    @State private var title = ""
    @State private var ingredients = [Int: String]()
    @State private var instructions = ""
    @State private var showQueryField = false
    @State private var query = ""
    @State private var selectedItem: PhotosPickerItem? = nil
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Recipe Title")) {
                    TextField("Title", text: $title)
                }
                Section(header:
                            HStack {
                    Text("Ingrediants")
                    Spacer()
                    Image(systemName: "plus.circle")
                        .imageScale(.small)
                        .onTapGesture(perform: {
                            //add ingrediants
                            query = ""
                            showQueryField = true
                        })
                }
                ) {
                    if ingredients.isEmpty {
                        Text("Add ingrediants")
                            .foregroundColor(.gray)
                    } else {
                        ForEach(ingredients.keys.sorted(), id: \.self) { key in
                            if let value = ingredients[key] {
                                HStack {
                                    Text("\(value)")
                                    Spacer()
                                    Button(action: {
                                        // delete ingrediant
                                        ingredients[key] = nil
                                    }, label: {
                                        Image(systemName: "trash")
                                            .imageScale(.small)
                                            .foregroundColor(.red)
                                    })
                                }
                            }
                        }
                    }
                }
                Section(header: Text("Instructions")) {
                    TextField("Instructions", text: $instructions, axis: .vertical)
                        .lineLimit(5...)
                }
                Section(header:
                            HStack {
                    Text("Upload image")
                    Spacer()
                    PhotosPicker(selection: $selectedItem,
                                 matching: .images,
                                 photoLibrary: .shared()) {
                        Image(systemName: "plus.circle")
                            .imageScale(.small)
                    }
                    
                }) {
                    if let imageData = myRecipesViewModel.selectedImageData,
                       let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 350, height: 250)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        myRecipesViewModel.addingRecipe = false
                        dismiss()
                    }, label: {
                        Text("Cancel")
                    })
                }
                ToolbarItem(placement: .principal) {
                    Text("Adding New Recipe")
                        .font(.headline)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        myRecipesViewModel.addNewRecipe(title: title,
                                                        ingredients: ingredients,
                                                        instructions: instructions,
                                                        imageData: myRecipesViewModel.selectedImageData)
                        myRecipesViewModel.addingRecipe = false
                        dismiss()
                    }, label: {
                        Text("Add")
                    })
                    .disabled(title.isEmpty || ingredients.count == 0 || instructions.isEmpty)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .alert(
                "Add ingrediant",
                isPresented: $showQueryField,
                actions: {
                    TextField("Add ingrediant", text: $query)
                    Button("Add") {
                        // Add button action
                        let key = ingredients.count + 1
                        ingredients[key] = query
                    }
                }
            )
            .onChange(of: selectedItem) {
                Task {
                    // Retrieve selected asset in the form of Data
                    if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                        myRecipesViewModel.selectedImageData = data
                    }
                }
            }
            .onAppear(perform: {
                myRecipesViewModel.selectedImageData = nil
            })
        }
    }
}

#Preview {
    AddRecipeView()
        .environmentObject(MyRecipesViewModel())
}
