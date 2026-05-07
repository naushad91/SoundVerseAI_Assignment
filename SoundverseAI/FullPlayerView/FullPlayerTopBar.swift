//
//  FullPlayerTopBar.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 08/05/26.
//


import SwiftUI

struct FullPlayerTopBar: View {

    var onDismiss: () -> Void

    var body: some View {

        VStack(spacing: 18) {

            RoundedRectangle(cornerRadius: 3)
                .fill(
                    Color.white.opacity(0.18)
                )
                .frame(width: 44, height: 4)

            HStack {

                Button(action: onDismiss) {

                    Image(systemName: "chevron.down")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(
                            DS.Colors.textSecondary
                        )
                        .frame(width: 40, height: 40)
                }

                Spacer()

                Text("Now Playing")
                    .font(AppFont.metadata())
                    .foregroundStyle(
                        DS.Colors.textSecondary
                    )

                Spacer()

                Button {

                } label: {

                    Image(systemName: "ellipsis")
                        .rotationEffect(.degrees(90))
                        .font(.system(size: 18))
                        .foregroundStyle(
                            DS.Colors.textSecondary
                        )
                        .frame(width: 40, height: 40)
                }
            }
        }
        .padding(.horizontal, DS.Spacing.screenPadding)
        .padding(.top, 12)
    }
}