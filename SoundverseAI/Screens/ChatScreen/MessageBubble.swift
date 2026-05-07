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
            if isCurrentUser { Spacer(minLength: 52) }

            Text(message)
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(DS.Colors.textPrimary)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(bubbleBackground)
                .clipShape(bubbleShape)
                .overlay {
                    bubbleShape
                        .stroke(
                            isCurrentUser
                                ? DS.Colors.primary.opacity(0.3)
                                : DS.Colors.border,
                            lineWidth: 1
                        )
                }
                .shadow(
                    color: isCurrentUser
                        ? DS.Colors.primary.opacity(0.2)
                        : .black.opacity(0.18),
                    radius: 16,
                    x: 0,
                    y: 6
                )

            if !isCurrentUser { Spacer(minLength: 52) }
        }
        .padding(.horizontal, DS.Spacing.screenPadding)
    }

    // MARK: - Bubble Shape (sharp tail corner)

    private var bubbleShape: BubbleShape {
        BubbleShape(
            radius: DS.Radius.medium,
            isCurrentUser: isCurrentUser
        )
    }

    // MARK: - Bubble Background

    @ViewBuilder
    private var bubbleBackground: some View {
        if isCurrentUser {
            LinearGradient(
                colors: [DS.Colors.primary, DS.Colors.secondary],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        } else {
            LinearGradient(
                colors: [DS.Colors.surface, DS.Colors.surface.opacity(0.75)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }
}

// MARK: - Custom Bubble Shape

struct BubbleShape: Shape {

    var radius: CGFloat
    let isCurrentUser: Bool

    func path(in rect: CGRect) -> Path {
        let r = radius
        let w = rect.width
        let h = rect.height

        // Corners: topLeft, topRight, bottomRight, bottomLeft
        // Sharp corner is bottom-right for user, bottom-left for AI
        let topLeft     = CGSize(width: r, height: r)
        let topRight    = CGSize(width: r, height: r)
        let bottomRight = isCurrentUser ? CGSize(width: 4, height: 4) : CGSize(width: r, height: r)
        let bottomLeft  = isCurrentUser ? CGSize(width: r, height: r) : CGSize(width: 4, height: 4)

        var path = Path()

        path.move(to: CGPoint(x: topLeft.width, y: 0))

        // Top edge → top-right
        path.addLine(to: CGPoint(x: w - topRight.width, y: 0))
        path.addQuadCurve(
            to: CGPoint(x: w, y: topRight.height),
            control: CGPoint(x: w, y: 0)
        )

        // Right edge → bottom-right
        path.addLine(to: CGPoint(x: w, y: h - bottomRight.height))
        path.addQuadCurve(
            to: CGPoint(x: w - bottomRight.width, y: h),
            control: CGPoint(x: w, y: h)
        )

        // Bottom edge → bottom-left
        path.addLine(to: CGPoint(x: bottomLeft.width, y: h))
        path.addQuadCurve(
            to: CGPoint(x: 0, y: h - bottomLeft.height),
            control: CGPoint(x: 0, y: h)
        )

        // Left edge → top-left
        path.addLine(to: CGPoint(x: 0, y: topLeft.height))
        path.addQuadCurve(
            to: CGPoint(x: topLeft.width, y: 0),
            control: CGPoint(x: 0, y: 0)
        )

        path.closeSubpath()
        return path
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
