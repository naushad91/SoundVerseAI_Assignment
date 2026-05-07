//
//  AppTab.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 08/05/26.
//


import SwiftUI

// MARK: - App Tabs
enum AppTab: Int, CaseIterable {

    case home
    case chat
    case activity
    case library

    var icon: String {
        switch self {
        case .home:
            return "house"

        case .chat:
            return "sparkles"

        case .activity:
            return "bell"

        case .library:
            return "music.note.tv"
        }
    }

    var title: String {
        switch self {
        case .home:
            return "Home"

        case .chat:
            return "Chat"

        case .activity:
            return "Activity"

        case .library:
            return "Library"
        }
    }
}

// MARK: - Custom Tab Bar
struct CustomTabBar: View {

    @Binding var selectedTab: AppTab

    var body: some View {

        HStack {

            ForEach(AppTab.allCases, id: \.rawValue) { tab in

                CustomTabButton(
                    icon: tab.icon,
                    title: tab.title,
                    isSelected: selectedTab == tab
                ) {

                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                        selectedTab = tab
                    }
                }

                if tab != AppTab.allCases.last {
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 30)
        .padding(.top, 18)
        .padding(.bottom, 30)
        .background(
            Color.white.opacity(0.05)
        )
        .overlay(
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(.white.opacity(0.1)),
            alignment: .top
        )
    }
}

