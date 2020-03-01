// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let search = try? newJSONDecoder().decode(Search.self, from: jsonData)

import Foundation

// MARK: - Search
public struct Search: Codable {
    public let data: [SearchDatum]
    public let total: Int
    public let next: String?

    public init(data: [SearchDatum], total: Int, next: String) {
        self.data = data
        self.total = total
        self.next = next
    }
}
