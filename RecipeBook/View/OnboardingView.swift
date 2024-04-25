//
//  OnboardingView.swift
//  RecipeBook
//
//  Created by Zalak Khatri on 4/17/24.
//

import SwiftUI

struct OnboardingView: View {
    @State private var selectedView = 1
    let maxNumberOfScreens = 2
    // We set this value to false (in case it doesn't already exist)
    @AppStorage(Constants.Onboarding.currentOnboardingVersion) private var hasSeenOnboardingView = false

    var body: some View {
        VStack {
            TabView(selection: $selectedView) {
                // Example screen 1
                OnboardingScreen(item: OnboardingItem(systemImageName: "magnifyingglass", title: Constants.Onboarding.title1, subtitle: Constants.Onboarding.subTitle1)).tag(1)

                // Example screen 2
                OnboardingScreen(item: OnboardingItem(systemImageName: "rectangle.and.pencil.and.ellipsis", title: Constants.Onboarding.title2, subtitle: Constants.Onboarding.subTitle2)).tag(2)
            }
            // Allows you to swipe through the tabs,
            // if you only have one onboarding screen, the dots at the bottom of the screen that indicate what tab you are on, won't be displayed
            .tabViewStyle(.page)
            // Displays the background behind the tab indicator dots so that they can been seen in light and dark mode
            .indexViewStyle(.page(backgroundDisplayMode: .always))

            Button(selectedView == maxNumberOfScreens ? "Done" : "Next") {
                if selectedView == maxNumberOfScreens {
                    // Save the completedOnboarding state and exit the view
                    hasSeenOnboardingView = true
                } else {
                    selectedView += 1
                }
            }
            .buttonStyle(.borderedProminent)
            .padding(.vertical)
        }
    }
}


struct OnboardingScreen: View {
    let item: OnboardingItem

    var body: some View {
        ScrollView {
            VStack {
                Image(systemName: item.systemImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 100, maxHeight: 100)
                    .padding(.bottom)

                VStack(alignment: .leading) {
                    Text(item.title)
                        .bold()
                        .font(.title)
                        .padding(.bottom)

                    Text(item.subtitle)
                        .padding(.bottom)
                }
            }
            .padding()
        }
    }
}

#Preview {
    OnboardingView()
}
