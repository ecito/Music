// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let artist = try? newJSONDecoder().decode(Artist.self, from: jsonData)

import Foundation

// MARK: - Artist
public struct Artist: Codable {
    public let id: Int
    public let name: String
    public let picture: String?
    public let pictureSmall, pictureMedium, pictureBig, pictureXl: String?
    public let tracklist: String
    public let type: String
    public let link: String?

    enum CodingKeys: String, CodingKey {
        case id, name, picture
        case pictureSmall
        case pictureMedium
        case pictureBig
        case pictureXl
        case tracklist, type, link
    }

    public init(id: Int, name: String, picture: String, pictureSmall: String, pictureMedium: String, pictureBig: String, pictureXl: String, tracklist: String, type: String, link: String?) {
        self.id = id
        self.name = name
        self.picture = picture
        self.pictureSmall = pictureSmall
        self.pictureMedium = pictureMedium
        self.pictureBig = pictureBig
        self.pictureXl = pictureXl
        self.tracklist = tracklist
        self.type = type
        self.link = link
    }
}
