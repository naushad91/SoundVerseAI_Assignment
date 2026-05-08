//
//  AppRouter.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 08/05/26.
//


import Foundation
import Combine
final class AppRouter: ObservableObject {

    @Published var selectedTab: AppTab = .home
}
