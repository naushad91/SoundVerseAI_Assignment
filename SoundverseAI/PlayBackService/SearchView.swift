//
//  SearchView.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 08/05/26.
//


import SwiftUI

struct SearchView: View {

    @StateObject private var vm = SearchViewModel()

    @EnvironmentObject var player: AudioPlayerManager

    var body: some View {

        VStack(spacing: 0) {

            // MARK: - Top Bar
            AppTopBar(
                title: "Search"
            )

            // MARK: - Search Field
            searchField

            // MARK: - Content
            ScrollView(showsIndicators: false) {

                LazyVStack(spacing: 16) {

                    if vm.isLoading {

                        ProgressView()
                            .tint(.white)
                            .padding(.top, 40)
                    }

                    ForEach(vm.tracks) { track in

                        trackCard(track)
                    }

                    Spacer(minLength: 140)
                }
                .padding(.top, 22)
                .padding(.horizontal, DS.Spacing.screenPadding)
            }
        }
        .appBackground()
        .toolbar(.hidden, for: .navigationBar)
    }
}

// MARK: - Search Field
private extension SearchView {

    var searchField: some View {

        HStack(spacing: 12) {

            Image(systemName: "magnifyingglass")
                .foregroundStyle(
                    DS.Colors.textSecondary
                )

            TextField(
                "Search songs...",
                text: $vm.searchText
            )
            .font(AppFont.artistName())
            .foregroundStyle(
                DS.Colors.textPrimary
            )
            .submitLabel(.search)

            Button {

                Task {
                    await vm.search()
                }

            } label: {

                Image(systemName: "arrow.up")
                    .font(
                        .system(
                            size: 14,
                            weight: .bold
                        )
                    )
                    .foregroundStyle(.white)
                    .frame(width: 34, height: 34)
                    .background(
                        DS.Gradients.primaryGradient
                    )
                    .clipShape(Circle())
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(
            DS.Colors.surface
        )
        .clipShape(
            RoundedRectangle(
                cornerRadius: DS.Radius.large,
                style: .continuous
            )
        )
        .overlay {

            RoundedRectangle(
                cornerRadius: DS.Radius.large,
                style: .continuous
            )
            .stroke(
                DS.Colors.border,
                lineWidth: 1
            )
        }
        .padding(.horizontal, DS.Spacing.screenPadding)
        .padding(.top, 18)
    }
}

// MARK: - Track Card
private extension SearchView {

    func trackCard(
        _ track: MusicTrack
    ) -> some View {

        Button {

            player.play(track: track)

        } label: {

            HStack(spacing: 14) {

                AsyncImage(
                    url: URL(string: track.album.cover_big)
                ) { phase in

                    switch phase {

                    case .success(let image):

                        image
                            .resizable()
                            .scaledToFill()

                    default:

                        Rectangle()
                            .fill(
                                DS.Colors.surface
                            )
                    }
                }
                .frame(width: 64, height: 64)
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 18,
                        style: .continuous
                    )
                )

                VStack(
                    alignment: .leading,
                    spacing: 5
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

                Spacer()

                Image(systemName: "play.fill")
                    .font(
                        .system(
                            size: 14,
                            weight: .bold
                        )
                    )
                    .foregroundStyle(
                        DS.Colors.textPrimary
                    )
            }
            .padding(14)
            .background(
                DS.Colors.surface
            )
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 22,
                    style: .continuous
                )
            )
            .overlay {

                RoundedRectangle(
                    cornerRadius: 22,
                    style: .continuous
                )
                .stroke(
                    DS.Colors.border,
                    lineWidth: 1
                )
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {

    NavigationStack {
        SearchView()
    }
}
