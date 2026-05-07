//
//  FullPlayerTrackInfo.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 08/05/26.
//


import SwiftUI

struct FullPlayerTrackInfo: View {

    let title: String
    let artist: String

    var body: some View {

        VStack(spacing: 6) {

            Text(title)
                .font(AppFont.playerTitle())
                .foregroundStyle(
                    DS.Colors.textPrimary
                )
                .lineLimit(1)

            Text(artist)
                .font(AppFont.artistName())
                .foregroundStyle(
                    DS.Colors.textSecondary
                )
        }
        .padding(.horizontal, 28)
    }
}