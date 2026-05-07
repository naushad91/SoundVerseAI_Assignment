//
//  AppBackgroundModifier.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 08/05/26.
//


import SwiftUI

// MARK: - Background Modifier
struct AppBackgroundModifier: ViewModifier {

    func body(content: Content) -> some View {

        content
            .background {
                DS.Gradients.appBackground
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
