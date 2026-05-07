//
//  SideMenuView.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 08/05/26.
//


import SwiftUI

struct SideMenuView: View {

    var body: some View {

        VStack(alignment: .leading, spacing: 32) {

            // MARK: - Profile
            VStack(alignment: .leading, spacing: 14) {

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
                    .frame(width: 72, height: 72)
                    .overlay {

                        Image(systemName: "person.fill")
                            .font(.system(size: 28, weight: .semibold))
                            .foregroundStyle(.white)
                    }

                VStack(alignment: .leading, spacing: 4) {

                    Text("Naushad Khan")
                        .font(AppFont.sectionTitle())
                        .foregroundStyle(DS.Colors.textPrimary)

                    Text("Mobile Product Engineer")
                        .font(AppFont.metadata())
                        .foregroundStyle(DS.Colors.textSecondary)
                }
            }
            .padding(.top, 70)

            // MARK: - Menu Items
            VStack(alignment: .leading, spacing: 24) {

                SideMenuRow(
                    icon: "person.crop.circle",
                    title: "Profile"
                )

                SideMenuRow(
                    icon: "gearshape",
                    title: "Settings"
                )

                SideMenuRow(
                    icon: "bell.badge",
                    title: "Notifications"
                )

                SideMenuRow(
                    icon: "music.note.list",
                    title: "Playlists"
                )
            }

            Spacer()
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(width: 300)
        .background(
            ZStack {

                DS.Colors.backgroundSecondary

                LinearGradient(
                    colors: [
                        DS.Colors.primary.opacity(0.08),
                        .clear
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            }
        )
    }
}

// MARK: - Menu Row
struct SideMenuRow: View {

    let icon: String
    let title: String

    var body: some View {

        HStack(spacing: 16) {

            Image(systemName: icon)
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(DS.Colors.primary)
                .frame(width: 22)

            Text(title)
                .font(AppFont.artistName())
                .foregroundStyle(DS.Colors.textPrimary)
        }
    }
}

#Preview {
    SideMenuView()
}