//
//  CategoryBuilder.swift
//  BoosterTestTask
//
//  Created by Oleksii Shabalin on 8/9/22.
//

import UIKit

final class CategoryBuilder {

    static func viewController() -> CategoryViewController {
        /// View
        guard
            let viewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateInitialViewController() as? CategoryViewController
        else { fatalError("Could not get startScreenViewController from storyboard") }

        /// Interactor
        let interactor = CategoryInteractor(service: APIService.shared)

        /// Router
        let router = CategoryRouter(viewController: viewController)

        /// Presenter
        let presenter = CategoryPresenter(view: viewController,
                                          interactor: interactor,
                                          router: router)
        viewController.presenter = presenter

        return viewController
    }
}
