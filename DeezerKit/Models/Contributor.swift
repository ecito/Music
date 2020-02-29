// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let contributor = try? newJSONDecoder().decode(Contributor.self, from: jsonData)

import Foundation

// MARK: - Contributor
public struct Contributor: Codable {
    public let id: Int
    public let name: String
    public let link, share, picture: String
    public let pictureSmall, pictureMedium, pictureBig, pictureXl: String
    public let radio: Bool
    public let tracklist: String
    public let type: ArtistType
    public let role: String

    enum CodingKeys: String, CodingKey {
        case id, name, link, share, picture
        case pictureSmall
        case pictureMedium
        case pictureBig
        case pictureXl
        case radio, tracklist, type, role
    }

    public init(id: Int, name: String, link: String, share: String, picture: String, pictureSmall: String, pictureMedium: String, pictureBig: String, pictureXl: String, radio: Bool, tracklist: String, type: ArtistType, role: String) {
        self.id = id
        self.name = name
        self.link = link
        self.share = share
        self.picture = picture
        self.pictureSmall = pictureSmall
        self.pictureMedium = pictureMedium
        self.pictureBig = pictureBig
        self.pictureXl = pictureXl
        self.radio = radio
        self.tracklist = tracklist
        self.type = type
        self.role = role
    }
}
