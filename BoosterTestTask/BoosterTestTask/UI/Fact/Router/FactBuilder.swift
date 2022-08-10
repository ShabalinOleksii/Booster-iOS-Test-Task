//
//  FactBuilder.swift
//  BoosterTestTask
//
//  Created by Oleksii Shabalin on 8/10/22.
//

import Foundation

final class FactBuilder {

    static func viewController(entity: FactEntity) -> FactViewController {
        /// View
        let nibName = String(describing: FactViewController.self)
        let viewController = FactViewController(nibName: nibName, bundle: nil)

        /// Interactor
        let interactor = FactInteractor(entity: entity)

        /// Router
        let router = FactRouter(viewController: viewController)

        /// Presenter
        let presenter = FactPresenter(view: viewController,
                                      interactor: interactor,
                                      router: router)
        viewController.presenter = presenter

        return viewController
    }
}
