//
//  SearchViewModel.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 08/05/26.
//


import Foundation
import Combine
@MainActor
final class SearchViewModel: ObservableObject {

    // MARK: - Published Properties
    @Published var tracks: [MusicTrack] = []
    @Published var searchText = ""
    @Published var isLoading = false

    // MARK: - Search Tracks
    func search() async {

        guard !searchText.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty else {

            tracks = []
            return
        }

        isLoading = true

        defer {
            isLoading = false
        }

        do {

            tracks = try await NetworkManager.shared.searchTracks(
                query: searchText
            )

        } catch {

            print(
                "Search error:",
                error.localizedDescription
            )
        }
    }
}
