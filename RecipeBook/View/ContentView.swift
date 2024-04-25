//
//  ContentView.swift
//  RecipeBook
//
//  Created by Zalak Khatri on 4/4/24.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab = 0
    @StateObject private var searchRecipeViewModel = SearchRecipeViewModel()
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        TabView(selection: $selectedTab) {
            SearchRecipesView()
            .environmentObject(searchRecipeViewModel)
            .tabItem {
                Image(systemName: "house")
                    .resizable()
                Text("Home")
            }
            .tag(0)
            .toolbarBackground(colorScheme == .dark ? Color.black : Color.white, for: .tabBar)

            SavedRecipesView()
                .environmentObject(searchRecipeViewModel)
            .tabItem {
                Image(systemName: "bookmark")
                    .resizable()
                Text("Saved")
            }
            .tag(1)
            .toolbarBackground(colorScheme == .dark ? Color.black : Color.white, for: .tabBar)

            MyRecipesView()
            .tabItem {
                Image(systemName: "fork.knife.circle")
                    .resizable()
                Text("My Recipes")
            }
            .tag(2)
            .toolbarBackground(colorScheme == .dark ? Color.black : Color.white, for: .tabBar)
        }
    }
}

#Preview {
    ContentView()
}
