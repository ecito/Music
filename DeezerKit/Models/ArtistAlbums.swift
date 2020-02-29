// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let artistAlbums = try? newJSONDecoder().decode(ArtistAlbums.self, from: jsonData)

import Foundation

// MARK: - ArtistAlbums
public struct ArtistAlbums: Codable {
    public let data: [ArtistAlbumsDatum]
    public let total: Int
    public let next: String

    public init(data: [ArtistAlbumsDatum], total: Int, next: String) {
        self.data = data
        self.total = total
        self.next = next
    }
}
