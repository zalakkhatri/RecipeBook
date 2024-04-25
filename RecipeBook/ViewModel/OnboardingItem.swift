//
//  OnboardingItem.swift
//  RecipeBook
//
//  Created by Zalak Khatri on 4/17/24.
//

import Foundation

struct OnboardingItem: Identifiable {
    let id = UUID()
    let systemImageName: String
    let title: String
    let subtitle: String
}
