// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let tracks = try? newJSONDecoder().decode(Tracks.self, from: jsonData)

import Foundation

// MARK: - Tracks
public struct Tracks: Codable {
    public let data: [TracksDatum]
    public let total: Int

    public init(data: [TracksDatum], total: Int) {
        self.data = data
        self.total = total
    }
}
