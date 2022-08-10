//
//  CategoryModel.swift
//  BoosterTestTask
//
//  Created by Oleksii Shabalin on 8/9/22.
//

import Foundation

enum CategoryStatus: String {
    case free
    case paid
    case undefined
}

extension CategoryStatus {

    var name: String {
        switch self {
        case .free:
            return ""
        case .paid:
            return "Premium"
        case .undefined:
            return "Coming Soon"
        }
    }
}

final class CategoryModel: Decodable {

    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case image
        case order
        case status
        case content
    }

    // MARK: - Properties
    public private(set) var title: String
    public private(set) var description: String
    public private(set) var image: String
    public private(set) var order: Int
    public private(set) var status: CategoryStatus
    public private(set) var content: [FactModel]

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        image = try container.decode(String.self, forKey: .image)
        order = try container.decode(Int.self, forKey: .order)
        let categoryStatus = try container.decode(String.self, forKey: .status)
        content = (try? container.decode([FactModel].self, forKey: .content)) ?? []
        status = content.isEmpty ? .undefined : CategoryStatus(rawValue: categoryStatus) ?? .undefined
    }
}
