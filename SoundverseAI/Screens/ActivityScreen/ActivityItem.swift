//
//  ActivityItem.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 08/05/26.
//

import SwiftUI
// MARK: - Model
struct ActivityItem: Identifiable {

    let id = UUID()

    let user: String
    let message: String
    let time: String
    let icon: String
}
