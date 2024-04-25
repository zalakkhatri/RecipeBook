//
//  RecipeBookApp.swift
//  RecipeBook
//
//  Created by Zalak Khatri on 4/4/24.
//

import SwiftUI

@main
struct RecipeBookApp: App {
    @AppStorage(Constants.Onboarding.currentOnboardingVersion) private var hasSeenOnboardingView = false
    
    var body: some Scene {
        WindowGroup {
            // If user has seen onboarding screen the skipt it next time onwards
            if hasSeenOnboardingView {
                ContentView()
            } else {
                // Else go through onboarding screens
                OnboardingView()
            }
        }
    }
}
