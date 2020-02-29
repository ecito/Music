// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let artistElement = try? newJSONDecoder().decode(ArtistElement.self, from: jsonData)

import Foundation

// MARK: - ArtistElement
public struct ArtistElement: Codable {
    public let id: Int
    public let name: String
    public let picture: String?
    public let type: String
    public let tracklist: String?

    public init(id: Int, name: String, picture: String?, type: String, tracklist: String?) {
        self.id = id
        self.name = name
        self.picture = picture
        self.type = type
        self.tracklist = tracklist
    }
}
