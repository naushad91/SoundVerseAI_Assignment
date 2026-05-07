//
//  FullPlayerControls.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 08/05/26.
//


import SwiftUI

struct FullPlayerControls: View {

    @Binding var isPlaying: Bool
    @Binding var isShuffle: Bool
    @Binding var isRepeat: Bool

    var body: some View {

        HStack {

            controlButton(
                icon: "shuffle",
                isActive: isShuffle
            ) {

                isShuffle.toggle()
            }

            Spacer()

            playerButton(
                icon: "backward.end.fill"
            )

            Spacer()

            playPauseButton

            Spacer()

            playerButton(
                icon: "forward.end.fill"
            )

            Spacer()

            controlButton(
                icon: "repeat",
                isActive: isRepeat
            ) {

                isRepeat.toggle()
            }
        }
        .padding(.horizontal, 34)
    }
}

// MARK: - Components
private extension FullPlayerControls {

    func controlButton(
        icon: String,
        isActive: Bool,
        action: @escaping () -> Void
    ) -> some View {

        Button(action: action) {

            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundStyle(
                    isActive
                    ? DS.Colors.primary
                    : DS.Colors.textSecondary
                )
        }
        .buttonStyle(.plain)
    }

    func playerButton(
        icon: String
    ) -> some View {

        Button {

        } label: {

            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundStyle(
                    DS.Colors.textPrimary
                )
        }
        .buttonStyle(.plain)
    }

    var playPauseButton: some View {

        Button {

            isPlaying.toggle()

        } label: {

            ZStack {

                Circle()
                    .fill(
                        DS.Gradients.primaryGradient
                    )
                    .frame(width: 72, height: 72)
                    .shadow(
                        color: DS.Colors.primary.opacity(0.3),
                        radius: 16,
                        y: 8
                    )

                Image(
                    systemName: isPlaying
                    ? "pause.fill"
                    : "play.fill"
                )
                .font(
                    .system(
                        size: 26,
                        weight: .semibold
                    )
                )
                .foregroundStyle(.white)
            }
        }
        .buttonStyle(.plain)
    }
}