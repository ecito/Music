// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let genres = try? newJSONDecoder().decode(Genres.self, from: jsonData)

import Foundation

// MARK: - Genres
public struct Genres: Codable {
    public let data: [ArtistElement]

    public init(data: [ArtistElement]) {
        self.data = data
    }
}
