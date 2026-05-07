//
//  FullPlayerArtwork.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 08/05/26.
//

import SwiftUI

struct FullPlayerArtwork: View {

    let url: String
    var isPlaying: Bool = false

    private let artworkSize: CGFloat = 300

    var body: some View {

        ZStack {

            // MARK: - Soft Background Glow
            Circle()
                .fill(
                    DS.Colors.primary.opacity(0.16)
                )
                .frame(width: 260, height: 260)
                .blur(radius: 60)

            artworkImage
                .scaleEffect(isPlaying ? 1 : 0.985)
                .animation(
                    .easeInOut(duration: 1.8)
                    .repeatForever(autoreverses: true),
                    value: isPlaying
                )
        }
        .frame(
            width: artworkSize + 40,
            height: artworkSize + 40
        )
    }
}

// MARK: - Artwork
private extension FullPlayerArtwork {

    var artworkImage: some View {

        AsyncImage(
            url: URL(string: url)
        ) { phase in

            switch phase {

            case .success(let image):

                image
                    .resizable()
                    .scaledToFill()

            default:

                placeholderView
            }
        }
        .frame(
            width: artworkSize,
            height: artworkSize
        )
        .clipShape(
            RoundedRectangle(
                cornerRadius: 20,
                style: .continuous
            )
        )
        .overlay {

            RoundedRectangle(
                cornerRadius: 20,
                style: .continuous
            )
            .stroke(
                Color.white.opacity(0.06),
                lineWidth: 1
            )
        }
        .shadow(
            color: .black.opacity(0.35),
            radius: 20,
            y: 10
        )
    }

    var placeholderView: some View {

        RoundedRectangle(
            cornerRadius: 20,
            style: .continuous
        )
        .fill(
            DS.Colors.surface
        )
        .overlay {

            Image(systemName: "music.note")
                .font(
                    .system(
                        size: 42,
                        weight: .ultraLight
                    )
                )
                .foregroundStyle(
                    DS.Colors.textSecondary.opacity(0.35)
                )
        }
    }
}

#Preview {

    ZStack {

        DS.Gradients.appBackground
            .ignoresSafeArea()

        FullPlayerArtwork(
            url: "https://images.unsplash.com/photo-1514320291840-2e0a9bf2a9ae?w=600&q=80",
            isPlaying: true
        )
    }
}
