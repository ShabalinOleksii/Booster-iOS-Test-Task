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
        case .facts:
            pushToFacts()
        }
    }
}

private extension CategoryRouter {

    func pushToFacts() {
        // TODO: Implement transition + pass data.
    }
}
