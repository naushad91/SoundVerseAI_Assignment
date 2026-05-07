//
//  RootView.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 08/05/26.
//

import SwiftUI

struct RootView: View {

    @State private var selectedTab: AppTab = .home

    @State private var showMenu = false
    @State private var showFullPlayer = false

    @StateObject private var player = AudioPlayerManager.shared

    @GestureState private var dragOffset: CGFloat = 0

    var body: some View {

        ZStack(alignment: .leading) {

            // MARK: - Main Content
            mainContent
                .disabled(showMenu)
                .overlay {

                    if showMenu {

                        Color.black.opacity(0.35)
                            .ignoresSafeArea()
                            .onTapGesture {

                                withAnimation(.spring) {
                                    showMenu = false
                                }
                            }
                    }
                }
                .offset(x: showMenu ? 280 : 0)
                .scaleEffect(showMenu ? 0.94 : 1)
                .animation(
                    .spring(
                        response: 0.32,
                        dampingFraction: 0.82
                    ),
                    value: showMenu
                )

            // MARK: - Side Menu
            SideMenuView()
                .offset(x: showMenu ? 0 : -320)
                .animation(
                    .spring(
                        response: 0.32,
                        dampingFraction: 0.82
                    ),
                    value: showMenu
                )
        }
        .gesture(menuGesture)

        // MARK: - Environment Object
        .environmentObject(player)

        // MARK: - Full Player
        .fullScreenCover(
            isPresented: $showFullPlayer
        ) {

            FullPlayerView(
                isPresented: $showFullPlayer
            )
            .environmentObject(player)
        }
    }
}

// MARK: - Main Content
private extension RootView {

    var mainContent: some View {

        ZStack(alignment: .bottom) {

            // MARK: - Screens
            Group {

                switch selectedTab {

                case .home:

                    NavigationStack {

                        HomeView()
                    }
                    .environmentObject(player)

                case .search:

                    NavigationStack {

                        SearchView()
                    }
                    .environmentObject(player)

                case .activity:

                    NavigationStack {

                        ActivityView()
                    }
                    .environmentObject(player)

                case .chat:

                    NavigationStack {

                        ChatView()
                    }
                    .environmentObject(player)
                }
            }

            // MARK: - Bottom Player + Tab Bar
            VStack(spacing: 12) {

                StickyPlayerBar(
                    isPresented: $showFullPlayer
                )
                .environmentObject(player)
                .padding(.horizontal, 16)

                CustomTabBar(
                    selectedTab: $selectedTab
                )
            }
        }
        .ignoresSafeArea(edges: .bottom)

        // MARK: - Open Menu Environment
        .environment(\.openMenu) {

            withAnimation(.spring) {
                showMenu.toggle()
            }
        }
    }
}

// MARK: - Gesture
private extension RootView {

    var menuGesture: some Gesture {

        DragGesture()

            .updating($dragOffset) { value, state, _ in

                state = value.translation.width
            }

            .onEnded { value in

                // MARK: - Open Menu
                if value.translation.width > 100 {

                    withAnimation(.spring) {
                        showMenu = true
                    }
                }

                // MARK: - Close Menu
                if value.translation.width < -100 {

                    withAnimation(.spring) {
                        showMenu = false
                    }
                }
            }
    }
}

#Preview {
    RootView()
}
