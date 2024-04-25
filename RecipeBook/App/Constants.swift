//
//  Constants.swift
//  RecipeBook
//
//  Created by Zalak Khatri on 4/10/24.
//

import Foundation

enum Constants {
    enum UserDefaultKey {
        public static let myRecipes = "myRecipes"
        public static let savedRecipes = "savedRecipes"
    }
    
    enum Endpoints {
        public static let baseURLString = "https://food-recipes-with-images.p.rapidapi.com/"
    }

    enum Onboarding {
        public static let currentOnboardingVersion = "onboardingVersion_1.0.0"
        public static let title1 = "Easy to search recipes"
        public static let subTitle1 = "With this app you can easily search for any recipes."
        public static let title2 = "Save recipes"
        public static let subTitle2 = "With this app you can save your own recipes."

    }
    enum Hosts {
        public static let searchAPIhost = "food-recipes-with-images.p.rapidapi.com"
    }
    enum String {
        public static let post = "POST"
        public static let get = "GET"
        public static let rapidAPIHost = "X-RapidAPI-Host"
        public static let rapidAPIKey = "X-RapidAPI-Key"
    }
}
