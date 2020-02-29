// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let artistAlbumsDatum = try? newJSONDecoder().decode(ArtistAlbumsDatum.self, from: jsonData)

import Foundation

// MARK: - ArtistAlbumsDatum
public struct ArtistAlbumsDatum: Codable {
    public let id: Int
    public let title: String
    public let link, cover: String
    public let coverSmall, coverMedium, coverBig, coverXl: String
    public let genreID, fans: Int
    public let releaseDate: String
    public let recordType: RecordTypeEnum
    public let tracklist: String
    public let explicitLyrics: Bool
    public let type: RecordTypeEnum

    enum CodingKeys: String, CodingKey {
        case id, title, link, cover
        case coverSmall
        case coverMedium
        case coverBig
        case coverXl
        case genreID
        case fans
        case releaseDate
        case recordType
        case tracklist
        case explicitLyrics
        case type
    }

    public init(id: Int, title: String, link: String, cover: String, coverSmall: String, coverMedium: String, coverBig: String, coverXl: String, genreID: Int, fans: Int, releaseDate: String, recordType: RecordTypeEnum, tracklist: String, explicitLyrics: Bool, type: RecordTypeEnum) {
        self.id = id
        self.title = title
        self.link = link
        self.cover = cover
        self.coverSmall = coverSmall
        self.coverMedium = coverMedium
        self.coverBig = coverBig
        self.coverXl = coverXl
        self.genreID = genreID
        self.fans = fans
        self.releaseDate = releaseDate
        self.recordType = recordType
        self.tracklist = tracklist
        self.explicitLyrics = explicitLyrics
        self.type = type
    }
}
