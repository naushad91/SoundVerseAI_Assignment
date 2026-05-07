//
//  MusicTrack.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 08/05/26.
//


import Foundation

struct MusicTrack: Identifiable, Codable {

    let id: Int
    let title: String
    let artist: Artist
    let album: Album
    let preview: String

    struct Artist: Codable {
        let name: String
    }

    struct Album: Codable {
        let cover_big: String
    }
}