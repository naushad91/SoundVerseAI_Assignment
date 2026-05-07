//
//  SoundverseAIApp.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 07/05/26.
//

import SwiftUI

@main
struct SoundverseAIApp: App {

    init() {

        NotificationManager.shared
            .requestPermission()
    }

    var body: some Scene {

        WindowGroup {

            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}
