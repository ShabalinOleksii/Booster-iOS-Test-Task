//
//  CategoryInteractor.swift
//  BoosterTestTask
//
//  Created by Oleksii Shabalin on 8/9/22.
//

import Foundation

final class CategoryInteractor {

    private let service: APIServiceProtocol

    init(service: APIServiceProtocol) {
        self.service = service
    }
}

extension CategoryInteractor: CategoryInteractorProtocol {

    func getCategories(completion: @escaping (Swift.Result<[CategoryModel], Error>) -> Void) {
        service.getCategories(completion: completion)
    }
}
