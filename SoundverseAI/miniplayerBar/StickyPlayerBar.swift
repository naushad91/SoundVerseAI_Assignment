//
//  StickyPlayerBar.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 08/05/26.
//

import SwiftUI

struct StickyPlayerBar: View {

    @Binding var isPresented: Bool

    @EnvironmentObject var player: AudioPlayerManager

    private var progress: CGFloat {
        guard player.duration > 0 else { return 0 }
        return CGFloat(player.currentTime / player.duration)
    }

    var body: some View {

        if let track = player.currentTrack {

            Button {

                withAnimation(
                    .spring(
                        response: 0.38,
                        dampingFraction: 0.82
                    )
                ) {
                    isPresented = true
                }

            } label: {

                ZStack(alignment: .bottomLeading) {

                    // Original content
                    HStack(spacing: 14) {

                        // MARK: - Artwork
                        FullPlayerArtworkMini(
                            url: track.album.cover_big
                        )

                        // MARK: - Track Info
                        VStack(
                            alignment: .leading,
                            spacing: 3
                        ) {

                            Text(track.title)
                                .font(AppFont.artistName())
                                .foregroundStyle(
                                    DS.Colors.textPrimary
                                )
                                .lineLimit(1)

                            Text(track.artist.name)
                                .font(AppFont.caption())
                                .foregroundStyle(
                                    DS.Colors.textSecondary
                                )
                                .lineLimit(1)
                        }

                        Spacer(minLength: 10)

                        // MARK: - Controls
                        HStack(spacing: 18) {

                            playPauseButton

                            nextButton
                        }
                        .padding(.trailing, 4)
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 12)

                    // MARK: - Bottom Edge Progress Bar (full width)
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .fill(DS.Colors.surface.opacity(0.35))
                                .frame(height: 3)
                                .cornerRadius(1.5)

                            Rectangle()
                                .fill(DS.Gradients.primaryGradient)
                                .frame(width: geo.size.width * progress, height: 3)
                                .cornerRadius(1.5)
                        }
                        .frame(height: 3)
                        .padding(.horizontal, 0)
                        .padding(.bottom, 0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .allowsHitTesting(false)
                    }
                    .frame(height: 3) // ensure GeometryReader is minimal
                }
                .background(playerBackground)
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 24,
                        style: .continuous
                    )
                )
                .overlay {

                    RoundedRectangle(
                        cornerRadius: 24,
                        style: .continuous
                    )
                    .strokeBorder(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.08),
                                Color.white.opacity(0.02)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
                }
                .shadow(
                    color: .black.opacity(0.34),
                    radius: 24,
                    y: 12
                )
            }
            .buttonStyle(.plain)
            .animation(.linear(duration: 0.1), value: player.currentTime)
        }
    }
}

// MARK: - Components
private extension StickyPlayerBar {

    var playPauseButton: some View {

        Button {

            player.togglePlayback()

        } label: {

            ZStack {

                Circle()
                    .fill(
                        DS.Gradients.primaryGradient
                    )
                    .frame(width: 38, height: 38)

                Image(
                    systemName: player.isPlaying
                    ? "pause.fill"
                    : "play.fill"
                )
                .font(
                    .system(
                        size: 14,
                        weight: .bold
                    )
                )
                .foregroundStyle(.white)
                .offset(
                    x: player.isPlaying ? 0 : 1
                )
            }
        }
        .buttonStyle(.plain)
    }

    var nextButton: some View {

        Button {

        } label: {

            Image(systemName: "forward.fill")
                .font(
                    .system(
                        size: 16,
                        weight: .semibold
                    )
                )
                .foregroundStyle(
                    DS.Colors.textPrimary.opacity(0.85)
                )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Background
private extension StickyPlayerBar {

    var playerBackground: some View {

        ZStack {

            RoundedRectangle(
                cornerRadius: 24,
                style: .continuous
            )
            .fill(
                DS.Colors.backgroundSecondary.opacity(0.94)
            )

            RoundedRectangle(
                cornerRadius: 24,
                style: .continuous
            )
            .fill(.ultraThinMaterial)
            .opacity(0.28)

            // MARK: - Subtle Top Highlight
            LinearGradient(
                colors: [
                    Color.white.opacity(0.06),
                    .clear
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 24,
                    style: .continuous
                )
            )
        }
    }
}
