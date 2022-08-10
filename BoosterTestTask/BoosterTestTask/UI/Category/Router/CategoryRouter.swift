//
//  CategoryRouter.swift
//  BoosterTestTask
//
//  Created by Oleksii Shabalin on 8/9/22.
//

import Foundation

final class CategoryRouter {

    private let viewController: CategoryViewController

    init(viewController: CategoryViewController) {
        self.viewController = viewController
    }
}

extension CategoryRouter: CategoryRouterProtocol {

    func show(_ destination: CategoryDestination) {
        switch destination {
        case .facts(let entity):
            pushToFacts(with: entity)
        }
    }
}

private extension CategoryRouter {

    func pushToFacts(with entity: FactEntity) {
        guard let navigationController = viewController.navigationController else { return }

        let viewController = FactBuilder.viewController(entity: entity)

        navigationController.pushViewController(viewController, animated: true)
    }
}
