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

    var body: some View {

        VStack(spacing: 0) {

            // MARK: - Top Bar
            AppTopBar(
                title: "Home"
            )

            Spacer()

            // MARK: - Toast
            if showToast {

                HStack(spacing: 12) {

                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 18))

                    Text("Notification scheduled")
                        .font(.system(size: 15, weight: .semibold))
                }
                .foregroundStyle(
                    DS.Colors.toastText
                )
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
                .background(
                    DS.Gradients.primaryGradient
                )
                .clipShape(Capsule())
                .overlay {

                    Capsule()
                        .stroke(
                            Color.white.opacity(0.12),
                            lineWidth: 1
                        )
                }
                .shadow(
                    color: DS.Shadow.purpleGlow,
                    radius: 24,
                    x: 0,
                    y: 12
                )
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }

            Spacer()
        }
        .appBackground()
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
