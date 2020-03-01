// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let datum = try? newJSONDecoder().decode(Datum.self, from: jsonData)

import Foundation

// MARK: - SearchDatum
public struct SearchDatum: Codable {
    public let id: Int
    public let name: String
    public let link, picture: String
    public let pictureSmall, pictureMedium, pictureBig, pictureXl: String?
    public let nbAlbum, nbFan: Int?
    public let radio: Bool
    public let tracklist: String
    public let type: String

    enum CodingKeys: String, CodingKey {
        case id, name, link, picture
        case pictureSmall
        case pictureMedium
        case pictureBig
        case pictureXl
        case nbAlbum
        case nbFan
        case radio, tracklist, type
    }

    public init(id: Int, name: String, link: String, picture: String, pictureSmall: String, pictureMedium: String, pictureBig: String, pictureXl: String, nbAlbum: Int, nbFan: Int, radio: Bool, tracklist: String, type: String) {
        self.id = id
        self.name = name
        self.link = link
        self.picture = picture
        self.pictureSmall = pictureSmall
        self.pictureMedium = pictureMedium
        self.pictureBig = pictureBig
        self.pictureXl = pictureXl
        self.nbAlbum = nbAlbum
        self.nbFan = nbFan
        self.radio = radio
        self.tracklist = tracklist
        self.type = type
    }
}
