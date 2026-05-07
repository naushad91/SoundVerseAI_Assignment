//
//  ChatView.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 08/05/26.
//


import SwiftUI

struct ChatView: View {

    var body: some View {

        VStack(spacing: 0) {

            // MARK: - Header
            headerSection

            // MARK: - Messages
            ScrollView(showsIndicators: false) {

                VStack(spacing: 18) {

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
            inputBar
        }
        .appBackground()
    }
}

// MARK: - Header
private extension ChatView {

    var headerSection: some View {

        HStack {

            Circle()
                .fill(DS.Colors.surface)
                .frame(width: 42, height: 42)
                .overlay {

                    Image(systemName: "person.fill")
                        .foregroundStyle(.white)
                }

            Text("Soundverse AI")
                .font(.title3.bold())
                .foregroundStyle(DS.Colors.textPrimary)

            Spacer()

            Button {

            } label: {

                Circle()
                    .fill(DS.Colors.surface)
                    .frame(width: 42, height: 42)
                    .overlay {

                        Image(systemName: "bell")
                            .foregroundStyle(.white)
                    }
            }
        }
        .padding(.horizontal, DS.Spacing.screenPadding)
        .padding(.top, 14)
    }
}

// MARK: - Input Bar
private extension ChatView {

    var inputBar: some View {

        HStack(spacing: 14) {

            Text("Ask Soundverse...")
                .foregroundStyle(DS.Colors.textSecondary)

            Spacer()

            Button {

            } label: {

                Image(systemName: "arrow.up")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(width: 38, height: 38)
                    .background(
                        DS.Gradients.primaryGradient
                    )
                    .clipShape(Circle())
            }
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 16)
        .background(
            DS.Colors.surface
        )
        .clipShape(
            RoundedRectangle(
                cornerRadius: DS.Radius.large,
                style: .continuous
            )
        )
        .overlay {

            RoundedRectangle(
                cornerRadius: DS.Radius.large,
                style: .continuous
            )
            .stroke(
                DS.Colors.border,
                lineWidth: 1
            )
        }
        .padding(.horizontal, DS.Spacing.screenPadding)
        .padding(.bottom, 24)
    }
}

#Preview {
    ChatView()
}