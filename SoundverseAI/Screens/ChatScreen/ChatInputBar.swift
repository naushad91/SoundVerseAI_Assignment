//
//  ChatInputBar.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 08/05/26.
//


import SwiftUI

struct ChatInputBar: View {

    @Binding var text: String
    var onSend: () -> Void

    @FocusState private var isFocused: Bool
    @State private var isPressed = false

    private var hasText: Bool { !text.trimmingCharacters(in: .whitespaces).isEmpty }

    var body: some View {
        HStack(spacing: 12) {
            TextField("Ask Soundverse...", text: $text, axis: .vertical)
                .lineLimit(1...5)
                .foregroundStyle(DS.Colors.textPrimary)
                .focused($isFocused)
                .animation(.spring(response: 0.3, dampingFraction: 0.8), value: text)

            sendButton
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(sendBarBackground)
        .clipShape(RoundedRectangle(cornerRadius: DS.Radius.large, style: .continuous))
        .overlay(sendBarBorder)
        .padding(.horizontal, DS.Spacing.screenPadding)
        .padding(.bottom, 22)
        .animation(.spring(response: 0.35, dampingFraction: 0.75), value: isFocused)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: hasText)
    }

    // MARK: - Send Button

    private var sendButton: some View {
        Button {
            guard hasText else { return }
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            onSend()
        } label: {
            ZStack {
                Circle()
                    .fill(sendButtonFill)
                    .frame(width: 36, height: 36)
                    .shadow(
                        color: hasText ? Color.white.opacity(0.15) : .clear,
                        radius: 8, y: 3
                    )

                Image(systemName: hasText ? "arrow.up" : "waveform")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(hasText ? .white : DS.Colors.textSecondary)
                    .scaleEffect(isPressed ? 0.82 : 1)
                    .contentTransition(.symbolEffect(.replace.downUp))
            }
        }
        .buttonStyle(.plain)
        .scaleEffect(isPressed ? 0.92 : 1)
        ._onButtonGesture(
            pressing: { isPressed = $0 },
            perform: {}
        )
        .disabled(!hasText)
    }

    private var sendButtonFill: AnyShapeStyle {
        hasText
            ? AnyShapeStyle(DS.Gradients.primaryGradient)
            : AnyShapeStyle(DS.Colors.surface)
    }
    // MARK: - Background & Border

    private var sendBarBackground: some View {
        DS.Colors.surface
            .overlay(
                RoundedRectangle(cornerRadius: DS.Radius.large, style: .continuous)
                    .fill(
                        RadialGradient(
                            colors: [Color.white.opacity(isFocused ? 0.04 : 0), .clear],
                            center: .leading,
                            startRadius: 0,
                            endRadius: 180
                        )
                    )
            )
    }

    private var sendBarBorder: some View {
        RoundedRectangle(cornerRadius: DS.Radius.large, style: .continuous)
            .stroke(lineWidth: 1)
            .foregroundStyle(borderStyle)
    }

    private var borderStyle: AnyShapeStyle {
        isFocused
            ? AnyShapeStyle(DS.Gradients.primaryGradient.opacity(0.6))
            : AnyShapeStyle(DS.Colors.border)
    }
}
