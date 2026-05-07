//
//  CustomTabButton.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 08/05/26.
//

import SwiftUI


// MARK: - Custom Tab Button
struct CustomTabButton: View {

    let icon: String
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {

        Button(action: action) {

            VStack(spacing: 8) {

                Image(systemName: icon)
                    .font(.title2)

                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
            .foregroundColor(
                isSelected ?
                Color(red: 235/255, green: 180/255, blue: 255/255)
                :
                    .white.opacity(0.5)
            )
            .shadow(
                color: isSelected ?
                .purple.opacity(0.8)
                :
                    .clear,
                radius: 12
            )
        }
        .buttonStyle(.plain)
    }
}
