//
//  FactModel.swift
//  BoosterTestTask
//
//  Created by Oleksii Shabalin on 8/9/22.
//

import Foundation

final class FactModel: Decodable {

    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case fact
        case image
    }

    // MARK: - Properties
    public private(set) var fact: String
    public private(set) var image: String

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        fact = try container.decode(String.self, forKey: .fact)
        image = try container.decode(String.self, forKey: .image)
    }
}
