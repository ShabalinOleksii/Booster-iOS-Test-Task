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
            return "https://drive.google.com/uc?export=download&id=12L7OflAsIxPOF47ssRdKyjXoWbUrq4V5"
        }
    }
}

final class APIService {

    // MARK: - Singletone
    static let shared = APIService()

    private init() { }

    // MARK: - Methods
    func getCategories(completion: @escaping (Swift.Result<[CategoryModel], Error>) -> Void) {
        guard
            let url = URL(string: APILink.getCategories.url)
        else {
            completion(.failure(CategoryError(type: .internal(.invalidURL))))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let jsonData = try JSONDecoder().decode([CategoryModel].self, from: data)
                    completion(.success(jsonData))
                } catch {
                    completion(.failure(CategoryError(type: .internal(.decodeFailure))))
                }
            } else {
                completion(.failure(CategoryError(type: .unknown)))
            }
        }
        task.resume()

        /// -------------
        /// Local testing:

//        guard
//            let path = Bundle.main.path(forResource: "ios-challenge-words-booster", ofType: "json"),
//            let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe),
//            let categories = try? JSONDecoder().decode([CategoryModel].self, from: jsonData)
//        else {
//            completion(.failure(NSError()))
//            return
//        }
//
//        completion(.success(categories))
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
