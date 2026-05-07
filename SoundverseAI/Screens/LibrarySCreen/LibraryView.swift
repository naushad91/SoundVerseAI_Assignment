//
//  LibraryView.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 08/05/26.
//


import SwiftUI

struct LibraryView: View {

    var body: some View {

        VStack {

            AppTopBar(
                title: "Library"
            )

            Spacer()

            Text("Library Screen")
                .foregroundStyle(.white)

            Spacer()
        }
        .appBackground()
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    LibraryView()
}