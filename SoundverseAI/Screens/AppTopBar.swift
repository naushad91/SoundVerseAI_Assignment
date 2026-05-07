//
//  AppTopBar.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 08/05/26.
//


import SwiftUI

struct AppTopBar: View {

    let title: String

    var onProfileTap: (() -> Void)? = nil
    var onBellTap: (() -> Void)? = nil

    var body: some View {

        HStack(spacing: 14) {

            profileButton

            Text(title)
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(DS.Colors.textPrimary)

            Spacer()

            bellButton
        }
        .padding(.horizontal, DS.Spacing.screenPadding)
        .padding(.top, 12)
    }
}

// MARK: - Components
private extension AppTopBar {

    var profileButton: some View {

        Button {

            onProfileTap?()

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
                .frame(width: 42, height: 42)
                .overlay {

                    Image(systemName: "person.fill")
                        .foregroundStyle(.white)
                }
        }
        .buttonStyle(.plain)
    }

    var bellButton: some View {

        Button {

            onBellTap?()

        } label: {

            Circle()
                .fill(DS.Colors.surface)
                .frame(width: 42, height: 42)
                .overlay {

                    Image(systemName: "bell")
                        .foregroundStyle(.white)
                }
                .overlay {

                    Circle()
                        .stroke(
                            DS.Colors.border,
                            lineWidth: 1
                        )
                }
        }
        .buttonStyle(.plain)
    }
}