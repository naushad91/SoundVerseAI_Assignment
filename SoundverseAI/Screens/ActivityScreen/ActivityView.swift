//
//  ActivityView.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 08/05/26.
//

import SwiftUI

struct ActivityView: View {

    @State private var toastItem: ActivityItem? = nil

    private let notifications: [ActivityItem] = [
        .init(isUnread: true,  user: "Aman",         message: "liked your playlist",        time: "2m ago",  icon: "heart.fill"),
        .init(isUnread: true,  user: "Soundverse AI", message: "generated your workout mix", time: "10m ago", icon: "sparkles"),
        .init(isUnread: false, user: "Riya",          message: "started following you",      time: "1h ago",  icon: "person.badge.plus.fill"),
        .init(isUnread: false, user: "Weekly Recap",  message: "is now available",           time: "3h ago",  icon: "waveform.path.ecg")
    ]

    var body: some View {
        ZStack(alignment: .bottom) {

            VStack(spacing: 0) {

                AppTopBar(
                    title: "Activity",
                    showsBell: false
                )
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 16) {

                        ForEach(notifications) { item in
                            Button {
                                triggerNotification(for: item)
                            } label: {
                                ActivityCard(item: item)
                            }
                            .buttonStyle(.plain)
                        }

                        Spacer(minLength: 140)
                    }
                    .padding(.top, 28)
                    .padding(.horizontal, DS.Spacing.screenPadding)
                }
            }

            // MARK: - Toast
            if let item = toastItem {
                ActivityToast(item: item)
                    .padding(.bottom, 110)
                    .transition(
                        .move(edge: .bottom)
                        .combined(with: .opacity)
                    )
                    .zIndex(2) // ensure toast appears above StickyPlayerBar
            }
        }
        .appBackground()
        .toolbar(.hidden, for: .navigationBar)
    }

    // MARK: - Trigger

    private func triggerNotification(for item: ActivityItem) {
        NotificationManager.shared.scheduleNotification(for: item)

        withAnimation(.spring(response: 0.4, dampingFraction: 0.72)) {
            toastItem = item
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation(.easeInOut(duration: 0.3)) {
                toastItem = nil
            }
        }
    }
}

// MARK: - Activity Toast

private struct ActivityToast: View {

    let item: ActivityItem
    @State private var shimmer = false

    var body: some View {
        HStack(spacing: 10) {

            // Icon
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.18))
                    .frame(width: 30, height: 30)

                Image(systemName: item.icon)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.white)
            }

            // Message — actual activity content
            Group {
                Text(item.user)
                    .fontWeight(.semibold)
                + Text(" \(item.message)")
                    .fontWeight(.regular)
            }
            .font(AppFont.artistName())
            .foregroundStyle(.white)
            .lineLimit(1)

            Spacer()

            // Checkmark pill
            HStack(spacing: 4) {
                Image(systemName: "checkmark")
                    .font(.system(size: 9, weight: .black))
                Text("5s")
                    .font(.system(size: 10, weight: .semibold))
            }
            .foregroundStyle(.white.opacity(0.7))
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.white.opacity(0.14))
            .clipShape(Capsule())
        }
        .padding(.leading, 8)
        .padding(.trailing, 12)
        .padding(.vertical, 9)
        .background(toastBackground)
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .strokeBorder(
                    LinearGradient(
                        colors: [Color.white.opacity(0.28), Color.white.opacity(0.06)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1
                )
        )
        .shadow(color: DS.Colors.primary.opacity(0.3), radius: 10, y: 4)
        .padding(.horizontal, DS.Spacing.screenPadding)
    }

    private var toastBackground: some View {
        ZStack {
            DS.Gradients.primaryGradient

            GeometryReader { geo in
                LinearGradient(
                    colors: [.clear, Color.white.opacity(0.1), .clear],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .frame(width: geo.size.width * 0.4)
                .offset(x: shimmer ? geo.size.width : -geo.size.width * 0.4)
                .animation(.linear(duration: 1.6).repeatForever(autoreverses: false), value: shimmer)
            }
            .clipShape(Capsule())
        }
        .onAppear { shimmer = true }
    }
}
#Preview {
    NavigationStack {
        ActivityView()
    }
}
