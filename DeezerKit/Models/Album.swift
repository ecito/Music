// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let album = try? newJSONDecoder().decode(Album.self, from: jsonData)

import Foundation

// MARK: - Album
public struct Album: Codable {
    public let id: Int
    public let title, upc: String
    public let link, share, cover: String
    public let coverSmall, coverMedium, coverBig, coverXl: String?
    public let genreID: Int
    public let genres: Genres
    public let label: String
    public let nbTracks, duration, fans, rating: Int
    public let releaseDate: String
    public let recordType: RecordTypeEnum
    public let available: Bool
    public let tracklist: String
    public let explicitLyrics: Bool
    public let explicitContentLyrics, explicitContentCover: Int
    public let contributors: [Contributor]
    public let artist: Artist
    public let type: RecordTypeEnum
    public let tracks: Tracks

    enum CodingKeys: String, CodingKey {
        case id, title, upc, link, share, cover
        case coverSmall
        case coverMedium
        case coverBig
        case coverXl
        case genreID
        case genres, label
        case nbTracks
        case duration, fans, rating
        case releaseDate
        case recordType
        case available, tracklist
        case explicitLyrics
        case explicitContentLyrics
        case explicitContentCover
        case contributors, artist, type, tracks
    }

    public init(id: Int, title: String, upc: String, link: String, share: String, cover: String, coverSmall: String, coverMedium: String, coverBig: String, coverXl: String, genreID: Int, genres: Genres, label: String, nbTracks: Int, duration: Int, fans: Int, rating: Int, releaseDate: String, recordType: RecordTypeEnum, available: Bool, tracklist: String, explicitLyrics: Bool, explicitContentLyrics: Int, explicitContentCover: Int, contributors: [Contributor], artist: Artist, type: RecordTypeEnum, tracks: Tracks) {
        self.id = id
        self.title = title
        self.upc = upc
        self.link = link
        self.share = share
        self.cover = cover
        self.coverSmall = coverSmall
        self.coverMedium = coverMedium
        self.coverBig = coverBig
        self.coverXl = coverXl
        self.genreID = genreID
        self.genres = genres
        self.label = label
        self.nbTracks = nbTracks
        self.duration = duration
        self.fans = fans
        self.rating = rating
        self.releaseDate = releaseDate
        self.recordType = recordType
        self.available = available
        self.tracklist = tracklist
        self.explicitLyrics = explicitLyrics
        self.explicitContentLyrics = explicitContentLyrics
        self.explicitContentCover = explicitContentCover
        self.contributors = contributors
        self.artist = artist
        self.type = type
        self.tracks = tracks
    }
}
