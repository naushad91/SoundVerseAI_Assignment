//
//  ActivityView.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 08/05/26.
//

import SwiftUI

struct ActivityView: View {

    private let notifications: [ActivityItem] = [
        .init(
            user: "Aman",
            message: "liked your playlist",
            time: "2m ago",
            icon: "heart.fill"
        ),
        .init(
            user: "Soundverse AI",
            message: "generated your workout mix",
            time: "10m ago",
            icon: "sparkles"
        ),
        .init(
            user: "Riya",
            message: "started following you",
            time: "1h ago",
            icon: "person.badge.plus.fill"
        ),
        .init(
            user: "Weekly Recap",
            message: "is now available",
            time: "3h ago",
            icon: "waveform.path.ecg"
        )
    ]

    var body: some View {

        VStack(spacing: 0) {

            // MARK: - Top Bar
            AppTopBar(
                title: "Activity"
            )

            // MARK: - Notifications
            ScrollView(showsIndicators: false) {

                LazyVStack(spacing: 16) {

                    ForEach(notifications) { item in

                        ActivityCard(item: item)
                    }

                    Spacer(minLength: 120)
                }
                .padding(.top, 28)
                .padding(.horizontal, DS.Spacing.screenPadding)
            }
        }
        .appBackground()
        .toolbar(.hidden, for: .navigationBar)
    }
}



#Preview {
    NavigationStack {
        ActivityView()
    }
}
