//
//  ChatView.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 08/05/26.
//

import SwiftUI

struct ChatView: View {

    @State private var messageText = ""

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

                    Spacer(minLength: 120)
                }
                .padding(.top, 28)
            }

            // MARK: - Input Bar
            ChatInputBar(
                text: $messageText
            ) {

            }
        }
        .appBackground()
    }
}

#Preview {
    ChatView()
}
