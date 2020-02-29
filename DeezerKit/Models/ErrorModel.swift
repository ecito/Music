// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let error = try? newJSONDecoder().decode(Error.self, from: jsonData)

import Foundation

// MARK: - Error
public struct ErrorModel: Codable {
    public let type: String
    public let message: String
    public let code: Int

    public init(type: String, message: String, code: Int) {
        self.type = type
        self.message = message
        self.code = code
    }
}
