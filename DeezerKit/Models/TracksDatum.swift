// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let datum = try? newJSONDecoder().decode(Datum.self, from: jsonData)

import Foundation

// MARK: - Datum
public struct TracksDatum: Codable {
    public let id: Int
    public let readable: Bool
    public let title, titleShort, titleVersion, isrc: String
    public let link: String
    public let duration, trackPosition, diskNumber, rank: Int
    public let explicitLyrics: Bool
    public let explicitContentLyrics, explicitContentCover: Int
    public let preview: String
    public let artist: Artist
    public let type: String

    enum CodingKeys: String, CodingKey {
        case id, readable, title
        case titleShort
        case titleVersion
        case isrc, link, duration
        case trackPosition
        case diskNumber
        case rank
        case explicitLyrics
        case explicitContentLyrics
        case explicitContentCover
        case preview, artist, type
    }

    public init(id: Int, readable: Bool, title: String, titleShort: String, titleVersion: String, isrc: String, link: String, duration: Int, trackPosition: Int, diskNumber: Int, rank: Int, explicitLyrics: Bool, explicitContentLyrics: Int, explicitContentCover: Int, preview: String, artist: Artist, type: String) {
        self.id = id
        self.readable = readable
        self.title = title
        self.titleShort = titleShort
        self.titleVersion = titleVersion
        self.isrc = isrc
        self.link = link
        self.duration = duration
        self.trackPosition = trackPosition
        self.diskNumber = diskNumber
        self.rank = rank
        self.explicitLyrics = explicitLyrics
        self.explicitContentLyrics = explicitContentLyrics
        self.explicitContentCover = explicitContentCover
        self.preview = preview
        self.artist = artist
        self.type = type
    }
}
