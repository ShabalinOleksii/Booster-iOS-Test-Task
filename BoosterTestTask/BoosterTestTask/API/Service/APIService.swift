//
//  APIService.swift
//  BoosterTestTask
//
//  Created by Oleksii Shabalin on 8/9/22.
//

import Foundation
import UIKit

private enum APILink {
    case getCategories
}

extension APILink {

    var url: String {
        switch self {
        case .getCategories:
            return "https://github.com/AppSci/Words-Booster-iOS-TestTask#resources:~:text=Resources-,JSON%20Content%20Link,-Figma%20Link"
        }
    }
}

final class APIService {

    // MARK: - Singletone
    static let shared = APIService()

    private init() { }

    // MARK: - Methods
    func getCategories(completion: ([CategoryModel]) -> Void) {
        
    }

    func getImage(by url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                DispatchQueue.main.async { completion(UIImage(data: data)) }
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}
