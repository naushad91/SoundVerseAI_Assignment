//
//  RootView.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 08/05/26.
//


import SwiftUI

struct RootView: View {

    @State private var selectedTab: AppTab = .home

    var body: some View {

        ZStack(alignment: .bottom) {

            // MARK: - Screens
            Group {

                switch selectedTab {

                case .home:

                    NavigationStack {
                        HomeView()
                    }

                case .chat:

                    NavigationStack {
                        ChatView()
                    }

                case .activity:

                    NavigationStack {
                        ActivityView()
                    }

                case .library:

                    NavigationStack {
                        LibraryView()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // MARK: - Tab Bar
            CustomTabBar(
                selectedTab: $selectedTab
            )
            .zIndex(1)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    RootView()
}