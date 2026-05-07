//
//  AudioPlayerManager.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 08/05/26.
//


import Foundation
import Combine
import AVFoundation

@MainActor
final class AudioPlayerManager: ObservableObject {

    static let shared = AudioPlayerManager()

    // MARK: - Published State
    @Published var currentTrack: MusicTrack?
    @Published var isPlaying = false

    // Time in seconds
    @Published var currentTime: Double = 0
    @Published var duration: Double = 0

    // MARK: - Player
    private var player: AVPlayer?
    private var timeObserverToken: Any?

    private init() {}

    // MARK: - Play Track
    func play(
        track: MusicTrack
    ) {

        currentTrack = track

        guard let url = URL(
            string: track.preview
        ) else {
            return
        }

        // Clean up previous player/observer
        removeTimeObserver()
        player?.pause()
        player = nil
        currentTime = 0
        duration = 0

        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)

        // Observe duration once ready
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemNewAccessLogEntry,
            object: playerItem,
            queue: .main
        ) { [weak self] _ in
            guard let self else { return }
            self.updateDurationIfAvailable()
        }

        // Also observe status to capture duration
        playerItem.observe(\.status, options: [.new, .initial]) { [weak self] item, _ in
            Task { @MainActor in
                self?.updateDurationIfAvailable()
            }
        }

        addPeriodicTimeObserver()

        player?.play()
        isPlaying = true
    }

    // MARK: - Toggle Play Pause
    func togglePlayback() {

        guard let player else {
            return
        }

        if isPlaying {
            player.pause()
        } else {
            player.play()
        }

        isPlaying.toggle()
    }

    // MARK: - Seek by progress (0...1)
    func seek(toProgress progress: Double) {
        guard let player, duration > 0 else { return }
        let seconds = progress * duration
        let cmTime = CMTime(seconds: seconds, preferredTimescale: 600)
        player.seek(to: cmTime, toleranceBefore: .zero, toleranceAfter: .zero)
        currentTime = seconds
    }

    // MARK: - Stop
    func stop() {

        player?.pause()
        removeTimeObserver()
        player = nil

        isPlaying = false
        currentTime = 0
        duration = 0
        currentTrack = nil
    }
}

// MARK: - Private Helpers
private extension AudioPlayerManager {

    func addPeriodicTimeObserver() {
        guard let player else { return }

        // 10 times per second is smooth enough for UI
        let interval = CMTime(seconds: 0.1, preferredTimescale: 600)

        // Ensure any existing observer is removed first
        removeTimeObserver()

        timeObserverToken = player.addPeriodicTimeObserver(
            forInterval: interval,
            queue: .main
        ) { [weak self] time in
            guard let self else { return }
            self.currentTime = time.seconds
            // Keep duration updated if it becomes known later
            self.updateDurationIfAvailable()
        }
    }

    func removeTimeObserver() {
        if let token = timeObserverToken, let player {
            player.removeTimeObserver(token)
        }
        timeObserverToken = nil
    }

    func updateDurationIfAvailable() {
        guard let item = player?.currentItem else { return }
        let dur = item.duration
        if dur.isNumeric {
            let seconds = CMTimeGetSeconds(dur)
            if seconds.isFinite && seconds > 0 {
                duration = seconds
            }
        } else {
            // Deezer previews are typically ~30s; fallback if unknown
            if duration == 0 {
                duration = 30
            }
        }
    }
}

private extension CMTime {
    var isNumeric: Bool {
        // Consider numeric if valid and not indefinite/inf, and seconds is finite
        guard isValid else { return false }
        if flags.contains(.indefinite) { return false }
        let secs = seconds
        return secs.isFinite && !secs.isNaN
    }
}
