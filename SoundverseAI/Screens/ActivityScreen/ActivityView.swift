//
//  ActivityView.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 08/05/26.
//


import SwiftUI

struct ActivityView: View {

    var body: some View {

        VStack {

            AppTopBar(
                title: "Activity"
            )

            Spacer()

            Text("Activity Screen")
                .foregroundStyle(.white)

            Spacer()
        }
        .appBackground()
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    ActivityView()
}