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

        HStack(spacing: 14) {

            // MARK: - Icon
            ZStack {

                Circle()
                    .fill(
                        DS.Gradients.primaryGradient
                    )
                    .frame(width: 52, height: 52)

                Image(systemName: item.icon)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.white)
            }

            // MARK: - Content
            VStack(alignment: .leading, spacing: 6) {

                HStack(spacing: 0) {
                    Text(item.user)
                        .font(AppFont.artistName())
                        .foregroundStyle(DS.Colors.textPrimary)
                    Text(" \(item.message)")
                        .font(AppFont.metadata())
                        .foregroundStyle(DS.Colors.textSecondary)
                }

                Text(item.time)
                    .font(AppFont.caption())
                    .foregroundStyle(
                        DS.Colors.textSecondary.opacity(0.7)
                    )
            }

            Spacer()

            Circle()
                .fill(DS.Colors.primary)
                .frame(width: 8, height: 8)
        }
        .padding(16)
        .background(
            DS.Colors.surface
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
    }
}
