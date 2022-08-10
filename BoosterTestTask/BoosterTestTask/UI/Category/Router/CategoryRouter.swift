//
//  CategoryRouter.swift
//  BoosterTestTask
//
//  Created by Oleksii Shabalin on 8/9/22.
//

import UIKit

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
        case .alert(let alert):
            presentAlert(alert)
        }
    }
}

private extension CategoryRouter {

    func pushToFacts(with entity: FactEntity) {
        guard let navigationController = viewController.navigationController else { return }

        let viewController = FactBuilder.viewController(entity: entity)

        navigationController.pushViewController(viewController, animated: true)
    }

    func presentAlert(_ alert: CategoryDestination.Alert) {
        switch alert {
        case .unsupportedCategory:
            presentAlertCategoryUnsupported()
        case .advertisementRequest(let completion):
            presentAlertAdvertisementRequest(completion)
        }
    }

    func presentAlertCategoryUnsupported() {
        guard let navigationController = viewController.navigationController else { return }

        let alertController = UIAlertController(title: "Alert",
                                                message: "This category is unsupported yet.",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel))

        navigationController.present(alertController, animated: true)
    }

    func presentAlertAdvertisementRequest(_ completion: @escaping () -> Void) {
        guard let navigationController = viewController.navigationController else { return }

        let alertController = UIAlertController(title: "Watch Ad to continue",
                                                message: "",
                                                preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        alertController.addAction(UIAlertAction(title: "Show Ad", style: .default, handler: { _ in completion() }))

        navigationController.present(alertController, animated: true)
    }
}
