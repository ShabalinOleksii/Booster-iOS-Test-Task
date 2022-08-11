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

protocol APIServiceProtocol: AnyObject {

    func getCategories(completion: @escaping (Swift.Result<[CategoryModel], Error>) -> Void)
}

final class APIService {

    // MARK: - Singletone
    static let shared = APIService()

    private init() { }

}

// MARK: - APIServiceProtocol
extension APIService: APIServiceProtocol {

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
                    // Writing data to local storage.
                    FileStorage.write(data: data, to: "Categories")

                    // Reading data from local storage.
                    if let storedData = FileStorage.read(from: "Categories") {
                        let jsonData = try JSONDecoder().decode([CategoryModel].self, from: storedData)
                        completion(.success(jsonData))
                    } else {
                        completion(.failure(CategoryError(type: .internal(.storageException))))
                    }
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
}
