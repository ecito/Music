// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   public let chart = try? newJSONDecoder().decode(Chart.self, from: jsonData)

import Foundation

// MARK: - Chart
public struct Chart: Codable {
    public let tracks: Tracks
    public let albums: Albums
    public let artists: Artists
    public let playlists: Playlists
    public let podcasts: Albums
}

// MARK: - Albums
public struct Albums: Codable {
    public let data: [AlbumsDatum]
    public let total: Int
}

// MARK: - AlbumsDatum
public struct AlbumsDatum: Codable {
    public let id: Int
    public let title: String
    public let link, cover: String
    public let coverSmall, coverMedium, coverBig, coverXl: String?
    public let recordType: String
    public let tracklist: String
    public let explicitLyrics: Bool
    public let position: Int
    public let artist: ArtistElement
    public let type: String

    enum CodingKeys: String, CodingKey {
        case id, title, link, cover
        case coverSmall = "cover_small"
        case coverMedium = "cover_medium"
        case coverBig = "cover_big"
        case coverXl = "cover_xl"
        case recordType = "record_type"
        case tracklist
        case explicitLyrics = "explicit_lyrics"
        case position, artist, type
    }
}

// MARK: - Artists
public struct Artists: Codable {
    public let data: [ArtistElement]
    public let total: Int
}

// MARK: - Playlists
public struct Playlists: Codable {
    public let data: [PlaylistsDatum]
    public let total: Int
}

// MARK: - PlaylistsDatum
public struct PlaylistsDatum: Codable {
    public let id: Int
    public let title: String
    public let datumPublic: Bool
    public let link, picture: String
    public let pictureSmall, pictureMedium, pictureBig, pictureXl: String?
    public let checksum: String
    public let tracklist: String
    public let creationDate: String
    public let user: User
    public let type: String

    enum CodingKeys: String, CodingKey {
        case id, title
        case datumPublic = "public"
        case link, picture
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXl = "picture_xl"
        case checksum, tracklist
        case creationDate = "creation_date"
        case user, type
    }
}

// MARK: - User
public struct User: Codable {
    public let id: Int
    public let name: String
    public let tracklist: String
    public let type: String
}
