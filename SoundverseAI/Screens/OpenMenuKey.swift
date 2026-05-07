//
//  OpenMenuKey.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 08/05/26.
//


import SwiftUI

private struct OpenMenuKey: EnvironmentKey {

    static let defaultValue: (() -> Void)? = nil
}

extension EnvironmentValues {

    var openMenu: (() -> Void)? {
        get { self[OpenMenuKey.self] }
        set { self[OpenMenuKey.self] = newValue }
    }
}