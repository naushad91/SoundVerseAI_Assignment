//
//  DS.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 08/05/26.
//


import SwiftUI

// MARK: - Design System
enum DS {

    enum Colors {

        // MARK: - Brand Colors
        static let primary   = Color(hex: "#A855F7")
        static let secondary = Color(hex: "#3B82F6")
        static let tertiary  = Color(hex: "#06B6D4")

        // MARK: - Backgrounds
        static let backgroundPrimary   = Color(hex: "#020817")
        static let backgroundSecondary = Color(hex: "#0F172A")
        static let backgroundTertiary  = Color.black

        // MARK: - Text
        static let textPrimary   = Color.white
        static let textSecondary = Color.white.opacity(0.65)

        // MARK: - Surface
        static let surface = Color.white.opacity(0.06)

        // MARK: - Borders
        static let border = Color.white.opacity(0.08)

        // MARK: - Toast
        static let toastText = Color(hex: "#3B0764")
    }

    enum Gradients {

        static let appBackground = LinearGradient(
            colors: [
                DS.Colors.backgroundPrimary,
                DS.Colors.backgroundSecondary,
                DS.Colors.backgroundTertiary
            ],
            startPoint: .top,
            endPoint: .bottom
        )

        static let primaryGradient = LinearGradient(
            colors: [
                DS.Colors.primary,
                DS.Colors.secondary
            ],
            startPoint: .leading,
            endPoint: .trailing
        )
    }

    enum Shadow {

        static let purpleGlow = Color.purple.opacity(0.45)
    }

    enum Radius {

        static let large: CGFloat = 28
        static let medium: CGFloat = 20
        static let small: CGFloat = 14
    }

    enum Spacing {

        static let screenPadding: CGFloat = 24
    }
}

// MARK: - Hex Support
extension Color {

    init(hex: String) {

        let hex = hex.trimmingCharacters(in: .alphanumerics.inverted)

        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)

        let a, r, g, b: UInt64

        switch hex.count {

        case 3:
            (a, r, g, b) = (
                255,
                (int >> 8) * 17,
                (int >> 4 & 0xF) * 17,
                (int & 0xF) * 17
            )

        case 6:
            (a, r, g, b) = (
                255,
                int >> 16,
                int >> 8 & 0xFF,
                int & 0xFF
            )

        case 8:
            (a, r, g, b) = (
                int >> 24,
                int >> 16 & 0xFF,
                int >> 8 & 0xFF,
                int & 0xFF
            )

        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
