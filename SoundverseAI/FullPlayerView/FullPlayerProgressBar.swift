//
//  FullPlayerProgressBar.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 08/05/26.
//


import SwiftUI

struct FullPlayerProgressBar: View {

    @Binding var progress: CGFloat

    let currentTime: String
    let endTime: String

    // Callback when user drags/updates the progress (0...1)
    var onSeek: ((CGFloat) -> Void)?

    var body: some View {

        VStack(spacing: 8) {

            GeometryReader { geo in

                ZStack(alignment: .leading) {

                    Capsule()
                        .fill(
                            DS.Colors.surface
                        )
                        .frame(height: 4)

                    Capsule()
                        .fill(
                            DS.Gradients.primaryGradient
                        )
                        .frame(
                            width: geo.size.width * progress,
                            height: 4
                        )

                    Circle()
                        .fill(.white)
                        .frame(width: 12, height: 12)
                        .offset(
                            x: geo.size.width * progress - 6
                        )
                }
                .contentShape(Rectangle())
                .gesture(

                    DragGesture(minimumDistance: 0)
                        .onChanged { value in

                            let p = min(
                                max(
                                    value.location.x / geo.size.width,
                                    0
                                ),
                                1
                            )
                            progress = p
                            onSeek?(p)
                        }
                )
            }
            .frame(height: 14)

            HStack {

                Text(currentTime)

                Spacer()

                Text(endTime)
            }
            .font(AppFont.caption())
            .foregroundStyle(
                DS.Colors.textSecondary
            )
        }
        .padding(.horizontal, 28)
    }
}
