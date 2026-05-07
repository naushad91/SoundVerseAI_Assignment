//
//  FullPlayerView.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 08/05/26.
//

import SwiftUI

struct FullPlayerView: View {

    @Binding var isPresented: Bool

    @EnvironmentObject var player: AudioPlayerManager

    @State private var progress: CGFloat = 0
    @State private var isShuffle = false
    @State private var isRepeat = false

    var body: some View {

        ZStack {

            DS.Gradients.appBackground
                .ignoresSafeArea()

            VStack(spacing: 0) {

                FullPlayerTopBar(
                    onDismiss: {
                        isPresented = false
                    }
                )

                FullPlayerArtwork(
                    url: player.currentTrack?.album.cover_big ?? "",
                    isPlaying: player.isPlaying
                )
                .padding(.top, 34)

                FullPlayerTrackInfo(
                    title: player.currentTrack?.title ?? "No Track",
                    artist: player.currentTrack?.artist.name ?? "Unknown Artist"
                )
                .padding(.top, 28)

                FullPlayerProgressBar(
                    progress: Binding(
                        get: {
                            guard player.duration > 0 else { return 0 }
                            return CGFloat(player.currentTime / player.duration)
                        },
                        set: { newValue in
                            progress = newValue
                        }
                    ),
                    currentTime: formatTime(player.currentTime),
                    endTime: formatTime(player.duration),
                    onSeek: { p in
                        player.seek(toProgress: Double(p))
                    }
                )
                .padding(.top, 28)

                FullPlayerControls(
                    isPlaying: Binding(
                        get: {
                            player.isPlaying
                        },
                        set: { _ in
                            player.togglePlayback()
                        }
                    ),
                    isShuffle: $isShuffle,
                    isRepeat: $isRepeat
                )
                .padding(.top, 42)

                Spacer()
            }
            .padding(.bottom, 34)
        }
        .onAppear {
            // Keep local progress in sync if needed
            syncProgress()
        }
        .onChange(of: player.currentTime) { _ in
            syncProgress()
        }
        .onChange(of: player.duration) { _ in
            syncProgress()
        }
    }
}

private extension FullPlayerView {
    func syncProgress() {
        guard player.duration > 0 else {
            progress = 0
            return
        }
        progress = CGFloat(player.currentTime / player.duration)
    }

    func formatTime(_ seconds: Double) -> String {
        guard seconds.isFinite && seconds >= 0 else { return "0:00" }
        let total = Int(seconds.rounded())
        let m = total / 60
        let s = total % 60
        return "\(m):" + String(format: "%02d", s)
    }
}

#Preview {

    FullPlayerView(
        isPresented: .constant(true)
    )
}

