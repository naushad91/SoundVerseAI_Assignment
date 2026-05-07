//
//  AppBackgroundModifier.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 08/05/26.
//


import SwiftUI

// MARK: - Custom Modifier
struct AppBackgroundModifier: ViewModifier {

    func body(content: Content) -> some View {

        content
            .background {

                LinearGradient(
                    colors: [
                        Color(red: 2/255, green: 8/255, blue: 28/255),
                        Color(red: 4/255, green: 12/255, blue: 45/255),
                        Color.black
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            }
    }
}

// MARK: - View Extension
extension View {

    func appBackground() -> some View {
        modifier(AppBackgroundModifier())
    }
}