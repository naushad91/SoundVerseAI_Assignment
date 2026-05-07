//
//  HomeView.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 07/05/26.
//
import SwiftUI

// MARK: - Home View
struct HomeView: View {

    @State private var showToast = true
    @State private var toastVisible = false

    var body: some View {
        VStack(spacing: 0) {

            // MARK: - Top Bar
            AppTopBar(title: "Home")

            Spacer()

            // MARK: - Toast
            if showToast {
                ToastBanner()
                    .opacity(toastVisible ? 1 : 0)
                    .offset(y: toastVisible ? 0 : 20)
                    .onAppear {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.72)) {
                            toastVisible = true
                        }
                        // Auto-dismiss after 3s
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation(.easeInOut(duration: 0.35)) {
                                toastVisible = false
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                showToast = false
                            }
                        }
                    }
            }

            Spacer()
        }
        .appBackground()
        .toolbar(.hidden, for: .navigationBar)
    }
}

// MARK: - Toast Banner

private struct ToastBanner: View {

    @State private var shimmer = false

    var body: some View {
        HStack(spacing: 10) {

            // Pulsing icon
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.15))
                    .frame(width: 28, height: 28)

                Image(systemName: "checkmark")
                    .font(.system(size: 11, weight: .black))
                    .foregroundStyle(.white)
            }

            Text("Notification scheduled")
                .font(AppFont.artistName())
                .foregroundStyle(.white)

            Spacer()

            // Dismiss pip
            Circle()
                .fill(Color.white.opacity(0.18))
                .frame(width: 6, height: 6)
        }
        .padding(.leading, 6)
        .padding(.trailing, 16)
        .padding(.vertical, 8)
        .background(toastBackground)
        .clipShape(Capsule())
        .overlay(toastBorder)
        // Reduced, softer shadow
        .shadow(color: DS.Colors.primary.opacity(0.28), radius: 12, x: 0, y: 4)
        .padding(.horizontal, DS.Spacing.screenPadding)
    }

    // Shimmer sweep overlay
    private var toastBackground: some View {
        ZStack {
            DS.Gradients.primaryGradient

            // Moving shimmer band
            GeometryReader { geo in
                LinearGradient(
                    colors: [
                        .clear,
                        Color.white.opacity(0.12),
                        .clear
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .frame(width: geo.size.width * 0.45)
                .offset(x: shimmer
                    ? geo.size.width
                    : -geo.size.width * 0.45
                )
                .animation(
                    .linear(duration: 1.8)
                    .repeatForever(autoreverses: false),
                    value: shimmer
                )
            }
            .clipShape(Capsule())
        }
        .onAppear { shimmer = true }
    }

    private var toastBorder: some View {
        Capsule()
            .strokeBorder(
                LinearGradient(
                    colors: [
                        Color.white.opacity(0.3),
                        Color.white.opacity(0.06)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                lineWidth: 1
            )
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
