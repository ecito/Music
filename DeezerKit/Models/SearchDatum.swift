// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let searchDatum = try? newJSONDecoder().decode(SearchDatum.self, from: jsonData)

import Foundation

// MARK: - SearchDatum
public struct SearchDatum: Codable {
    public let id: Int
    public let readable: Bool
    public let title, titleShort: String
    public let titleVersion: String
    public let link: String
    public let duration, rank: Int
    public let explicitLyrics: Bool
    public let explicitContentLyrics, explicitContentCover: Int
    public let preview: String
    public let artist: Artist
    public let album: AlbumClass
    public let type: String

    enum CodingKeys: String, CodingKey {
        case id, readable, title
        case titleShort
        case titleVersion
        case link, duration, rank
        case explicitLyrics
        case explicitContentLyrics
        case explicitContentCover
        case preview, artist, album, type
    }

    public init(id: Int, readable: Bool, title: String, titleShort: String, titleVersion: String, link: String, duration: Int, rank: Int, explicitLyrics: Bool, explicitContentLyrics: Int, explicitContentCover: Int, preview: String, artist: Artist, album: AlbumClass, type: String) {
        self.id = id
        self.readable = readable
        self.title = title
        self.titleShort = titleShort
        self.titleVersion = titleVersion
        self.link = link
        self.duration = duration
        self.rank = rank
        self.explicitLyrics = explicitLyrics
        self.explicitContentLyrics = explicitContentLyrics
        self.explicitContentCover = explicitContentCover
        self.preview = preview
        self.artist = artist
        self.album = album
        self.type = type
    }
}
