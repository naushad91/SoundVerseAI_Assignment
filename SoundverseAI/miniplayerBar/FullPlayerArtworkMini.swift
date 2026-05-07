//
//  FullPlayerArtworkMini.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 08/05/26.
//


import SwiftUI

struct FullPlayerArtworkMini: View {

    let url: String

    var body: some View {

        AsyncImage(
            url: URL(string: url)
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
                    .overlay {

                        Image(systemName: "music.note")
                            .foregroundStyle(
                                DS.Colors.textSecondary
                            )
                    }
            }
        }
        .frame(width: 54, height: 54)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 14,
                style: .continuous
            )
        )
    }
}