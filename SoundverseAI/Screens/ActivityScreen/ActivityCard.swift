//
//  ActivityCard.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 08/05/26.
//

import SwiftUI

// MARK: - Activity Card
struct ActivityCard: View {

    let item: ActivityItem

    var body: some View {
        HStack(alignment: .top, spacing: 12) {

            // MARK: - Icon
            iconView

            // MARK: - Content
            VStack(alignment: .leading, spacing: 8) {

                // User + message inline
                Group {
                    Text(item.user)
                        .font(AppFont.artistName())
                        .foregroundStyle(DS.Colors.textPrimary)
                    + Text("  \(item.message)")
                        .font(AppFont.metadata())
                        .foregroundStyle(DS.Colors.textSecondary)
                }
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)

                // Time
                Text(item.time)
                    .font(AppFont.caption())
                    .foregroundStyle(DS.Colors.textSecondary.opacity(0.5))
            }

            Spacer(minLength: 8)

            // Unread pip
            if item.isUnread {
                Circle()
                    .fill(DS.Gradients.primaryGradient)
                    .frame(width: 7, height: 7)
                    .padding(.top, 5)
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 14)
        .background(cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: DS.Radius.medium, style: .continuous))
        .overlay(cardBorder)
    }

    // MARK: - Icon View

    private var iconView: some View {
        ZStack {
            // Soft glow behind
            Circle()
                .fill(DS.Colors.primary.opacity(0.15))
                .frame(width: 44, height: 44)
                .blur(radius: 6)

            Circle()
                .fill(DS.Colors.surface)
                .frame(width: 42, height: 42)
                .overlay(
                    Circle()
                        .strokeBorder(
                            DS.Colors.primary.opacity(0.25),
                            lineWidth: 1
                        )
                )

            Image(systemName: item.icon)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(
                    DS.Gradients.primaryGradient
                )
        }
        .frame(width: 44, height: 44)
    }

    // MARK: - Background

    private var cardBackground: some View {
        ZStack {
            DS.Colors.surface

            // Very subtle left edge accent
            HStack {
                Rectangle()
                    .fill(DS.Gradients.primaryGradient)
                    .frame(width: 2)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 2, style: .continuous)
                    )
                    .padding(.vertical, 10)
                Spacer()
            }
        }
    }

    private var cardBorder: some View {
        RoundedRectangle(cornerRadius: DS.Radius.medium, style: .continuous)
            .strokeBorder(
                LinearGradient(
                    colors: [
                        Color.white.opacity(0.08),
                        Color.white.opacity(0.03)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                lineWidth: 1
            )
    }
}
