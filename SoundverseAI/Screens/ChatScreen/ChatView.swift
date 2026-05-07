//
//  ChatView.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 08/05/26.
//

import SwiftUI

struct ChatView: View {

    @State private var messageText = ""

    // Approximate combined height of StickyPlayerBar + CustomTabBar
    // StickyPlayerBar ≈ 84, CustomTabBar ≈ 80
    private let bottomOverlayHeight: CGFloat = 164

    var body: some View {

        VStack(spacing: 0) {

            // MARK: - Top Bar
            AppTopBar(
                title: "Soundverse AI"
            )

            // MARK: - Messages
            ScrollView(showsIndicators: false) {

                LazyVStack(spacing: 18) {

                    MessageBubble(
                        message: "Play some late night vibes",
                        isCurrentUser: true
                    )

                    MessageBubble(
                        message: "I found a smooth lo-fi playlist for coding and relaxing.",
                        isCurrentUser: false
                    )

                    MessageBubble(
                        message: "Generate a workout mix",
                        isCurrentUser: true
                    )

                    MessageBubble(
                        message: "Your high energy gym playlist is ready.",
                        isCurrentUser: false
                    )
                }
                .padding(.top, 28)
                // Reserve space for StickyPlayerBar + TabBar so last messages aren't hidden
                .padding(.bottom, bottomOverlayHeight + 16)
            }

            // MARK: - Input Bar
            ChatInputBar(
                text: $messageText
            ) {

            }
            // Reserve space so input bar is not overlapped by the sticky player/tab bar
            .padding(.bottom, bottomOverlayHeight)
        }
        .font(AppFont.metadata())
        .appBackground()
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    NavigationStack {
        ChatView()
    }
}
