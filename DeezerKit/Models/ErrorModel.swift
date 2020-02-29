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

    enum LevelUpCodingKeys: String, CodingKey {
        case error
    }
    
    public init(from decoder: Decoder) throws {
        let container = try! decoder.container(keyedBy: LevelUpCodingKeys.self)
        let deezerNativeErrorContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .error)
        type = try deezerNativeErrorContainer.decode(String.self, forKey: .type)
        message = try deezerNativeErrorContainer.decode(String.self, forKey: .message)
        code = try deezerNativeErrorContainer.decode(Int.self, forKey: .code)
    }
}
