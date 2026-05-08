//
//  SoundverseAIApp.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 07/05/26.
//

import SwiftUI

@main
struct SoundverseAIApp: App {

    @StateObject private var router = AppRouter()

    init() {

        NotificationManager.shared
            .requestPermission()
    }

    var body: some Scene {

        WindowGroup {

            ContentView()
                .environmentObject(router)
                .preferredColorScheme(.dark)
        }
    }
}
