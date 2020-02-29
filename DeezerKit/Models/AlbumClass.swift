// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let albumClass = try? newJSONDecoder().decode(AlbumClass.self, from: jsonData)

import Foundation

// MARK: - AlbumClass
public struct AlbumClass: Codable {
    public let id: Int
    public let title: String
    public let cover: String
    public let coverSmall, coverMedium, coverBig, coverXl: String?
    public let tracklist: String
    public let type: String?

    enum CodingKeys: String, CodingKey {
        case id, title, cover
        case coverSmall
        case coverMedium
        case coverBig
        case coverXl
        case tracklist, type
    }

    public init(id: Int, title: String, cover: String, coverSmall: String, coverMedium: String, coverBig: String, coverXl: String, tracklist: String, type: String) {
        self.id = id
        self.title = title
        self.cover = cover
        self.coverSmall = coverSmall
        self.coverMedium = coverMedium
        self.coverBig = coverBig
        self.coverXl = coverXl
        self.tracklist = tracklist
        self.type = type
    }
}
