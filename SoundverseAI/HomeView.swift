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
    @State private var selectedTab: AppTab = .activity

    var body: some View {

        VStack {

            Spacer()

            // MARK: - Toast
            if showToast {

                HStack(spacing: 12) {

                    Image(systemName: "checkmark.circle")
                        .font(.title3)

                    Text("Notification scheduled")
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                .foregroundColor(
                    Color(red: 54/255, green: 0/255, blue: 80/255)
                )
                .padding(.horizontal, 28)
                .padding(.vertical, 18)
                .background(
                    LinearGradient(
                        colors: [
                            Color(red: 180/255, green: 110/255, blue: 255/255),
                            Color(red: 45/255, green: 125/255, blue: 255/255)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .clipShape(Capsule())
                .shadow(
                    color: .purple.opacity(0.5),
                    radius: 30
                )
                .padding(.bottom, 140)
            }

            Spacer()

            // MARK: - Reusable Tab Bar
            CustomTabBar(selectedTab: $selectedTab)
        }
        .appBackground()
    }
}

#Preview {
    HomeView()
}
