//
//  NetworkManager.swift
//  SoundverseAI
//
//  Created by Naushad Ali Khan on 08/05/26.
//

import Foundation

// MARK: - Network Error
enum NetworkError: LocalizedError, Equatable {
    case invalidURL
    case missingAPIKey
    case requestFailed(status: Int)
    case decodingFailed

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The request URL is invalid."
        case .missingAPIKey:
            return "The API key is missing. Please configure your RapidAPI key."
        case .requestFailed(let status):
            return "The server returned an error (status code \(status))."
        case .decodingFailed:
            return "Failed to decode the server response."
        }
    }
}

final class NetworkManager {

    static let shared = NetworkManager()

    private init() {}

    // MARK: - Base URL
    private let baseURL =
    "https://deezerdevs-deezer.p.rapidapi.com/search?q="

    // MARK: - API Key
    private let apiKey =
    Bundle.main.object(
        forInfoDictionaryKey: "RAPID_API_KEY"
    ) as? String ?? ""
    
    // MARK: - Search Tracks
    func searchTracks(query: String) async throws -> [MusicTrack] {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return [] }

        guard let encodedQuery = trimmed.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            throw NetworkError.invalidURL
        }

        guard let url = URL(string: baseURL + encodedQuery) else {
            throw NetworkError.invalidURL
        }

        guard !apiKey.isEmpty else {
            throw NetworkError.missingAPIKey
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "X-RapidAPI-Key")
        request.setValue("deezerdevs-deezer.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")

        let (data, response) = try await URLSession.shared.data(for: request)

        if let http = response as? HTTPURLResponse {
            // Debug status code
            print("Deezer status:", http.statusCode)
            guard 200..<300 ~= http.statusCode else {
                throw NetworkError.requestFailed(status: http.statusCode)
            }
        }

        do {
            let decoded = try JSONDecoder().decode(DeezerResponse.self, from: data)
            return decoded.data
        } catch {
            print("Decoding error:", error)
            throw NetworkError.decodingFailed
        }
    }
}

// MARK: - Deezer Response
private struct DeezerResponse: Codable {

    let data: [MusicTrack]
}
