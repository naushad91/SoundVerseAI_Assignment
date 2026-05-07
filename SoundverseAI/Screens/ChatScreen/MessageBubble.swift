//
//  MessageBubble.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 08/05/26.
//


import SwiftUI

struct MessageBubble: View {

    let message: String
    let isCurrentUser: Bool

    var body: some View {

        HStack {

            if isCurrentUser {
                Spacer(minLength: 60)
            }

            Text(message)
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(DS.Colors.textPrimary)
                .padding(.horizontal, 18)
                .padding(.vertical, 14)
                .background(
                    bubbleBackground
                )
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: DS.Radius.medium,
                        style: .continuous
                    )
                )
                .overlay {
                    RoundedRectangle(
                        cornerRadius: DS.Radius.medium,
                        style: .continuous
                    )
                    .stroke(
                        DS.Colors.border,
                        lineWidth: 1
                    )
                }
                .shadow(
                    color: isCurrentUser ?
                    DS.Colors.primary.opacity(0.18)
                    :
                        .black.opacity(0.2),
                    radius: 18,
                    x: 0,
                    y: 8
                )

            if !isCurrentUser {
                Spacer(minLength: 60)
            }
        }
        .padding(.horizontal, DS.Spacing.screenPadding)
    }

    // MARK: - Bubble Background
    @ViewBuilder
    private var bubbleBackground: some View {

        if isCurrentUser {

            LinearGradient(
                colors: [
                    DS.Colors.primary,
                    DS.Colors.secondary
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

        } else {

            LinearGradient(
                colors: [
                    DS.Colors.surface,
                    DS.Colors.surface.opacity(0.7)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }
}

#Preview {
    VStack(spacing: 20) {

        MessageBubble(
            message: "Play some late night vibes",
            isCurrentUser: true
        )

        MessageBubble(
            message: "I found a smooth lo-fi playlist for coding and relaxing.",
            isCurrentUser: false
        )
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .appBackground()
}