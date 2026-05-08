//
//  HomeView.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 07/05/26.
//
import SwiftUI

// MARK: - Home View
struct HomeView: View {

    // Reuse SearchViewModel so the search field on Home behaves like Search screen
    @StateObject private var searchVM = SearchViewModel()

    var body: some View {
        VStack(spacing: 0) {

            // MARK: - Top Bar
            AppTopBar(title: "Home")

            // MARK: - Search Field (same as SearchView)
            Spacer()
            
            IntroCard(
                title: "About Me",
                lines: [
                    "iOS Engineer passionate about building Soundverse AI for scalable next-gen music experiences.",
                    "Focused on sleek interfaces, real-time audio systems, and AI-powered interactions."
                ]
            )
            .padding(.bottom, 4)


            Spacer()
        }
        .appBackground()
        .toolbar(.hidden, for: .navigationBar)
    }
}

// MARK: - Search Field (reused from SearchView)
private extension HomeView {

    var searchField: some View {

        HStack(spacing: 12) {

            Image(systemName: "magnifyingglass")
                .foregroundStyle(
                    DS.Colors.textSecondary
                )

            TextField(
                "Search songs...",
                text: $searchVM.searchText
            )
            .font(AppFont.artistName())
            .foregroundStyle(
                DS.Colors.textPrimary
            )
            .submitLabel(.search)
            .onSubmit {
                Task { await searchVM.search() }
            }

            Button {

                Task {
                    await searchVM.search()
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

// MARK: - Intro Card
private struct IntroCard: View {

    let title: String
    let lines: [String]

    var body: some View {

        VStack(spacing: 14) {

            Text(title)
                .font(AppFont.sectionTitle())
                .foregroundStyle(
                    DS.Colors.textPrimary
                )
                .multilineTextAlignment(.center)

            VStack(spacing: 8) {

                ForEach(lines, id: \.self) { line in

                    Text(line)
                        .font(AppFont.metadata())
                        .foregroundStyle(
                            DS.Colors.textSecondary
                        )
                        .multilineTextAlignment(.center)
                        .fixedSize(
                            horizontal: false,
                            vertical: true
                        )
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .background(
            DS.Colors.surface
        )
        .clipShape(
            RoundedRectangle(
                cornerRadius: DS.Radius.medium,
                style: .continuous
            )
        )
        .overlay(
            RoundedRectangle(
                cornerRadius: DS.Radius.medium,
                style: .continuous
            )
            .stroke(
                DS.Colors.border,
                lineWidth: 1
            )
        )
        .padding(.horizontal, DS.Spacing.screenPadding)
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
