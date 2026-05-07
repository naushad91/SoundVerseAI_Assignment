//
//  AppTopBar.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 08/05/26.
//

import SwiftUI

struct AppTopBar: View {

    let title: String
    var showsBell: Bool = true

    @Environment(\.openMenu) private var openMenu

    var body: some View {

        HStack(spacing: 14) {

            profileButton

            Text(title)
                .font(AppFont.sectionTitle())
                .foregroundStyle(DS.Colors.textPrimary)

            Spacer()

            if showsBell {
                bellButton
            }
        }
        .padding(.horizontal, DS.Spacing.screenPadding)
        .padding(.top, 12)
    }
}

// MARK: - Components
private extension AppTopBar {

    // MARK: - Profile Button
    var profileButton: some View {

        Button {

            openMenu?()

        } label: {

            Circle()
                .fill(
                    LinearGradient(
                        colors: [
                            DS.Colors.primary,
                            DS.Colors.secondary
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 44, height: 44)
                .overlay {

                    Image(systemName: "person.fill")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white)
                }
        }
        .buttonStyle(.plain)
    }

    // MARK: - Bell Button
    var bellButton: some View {

        NavigationLink {

            ActivityView()

        } label: {

            ZStack(alignment: .topTrailing) {

                // MARK: - Base Circle
                Circle()
                    .fill(DS.Colors.surface)
                    .frame(width: 44, height: 44)
                    .overlay {

                        Circle()
                            .strokeBorder(
                                LinearGradient(
                                    colors: [
                                        Color.white.opacity(0.12),
                                        Color.white.opacity(0.04)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1
                            )
                    }

                // MARK: - Bell Icon
                Image(systemName: "bell.fill")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(

                        LinearGradient(
                            colors: [
                                .white,
                                Color.white.opacity(0.7)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(width: 44, height: 44)

                // MARK: - Notification Dot
                Circle()
                    .fill(DS.Gradients.primaryGradient)
                    .frame(width: 9, height: 9)
                    .overlay {

                        Circle()
                            .strokeBorder(
                                DS.Colors.backgroundPrimary,
                                lineWidth: 1.5
                            )
                    }
                    .offset(x: 1, y: 1)
            }
        }
        .buttonStyle(.plain)
    }
}
