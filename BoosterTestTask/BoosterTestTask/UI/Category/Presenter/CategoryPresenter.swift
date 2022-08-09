//
//  CategoryPresenter.swift
//  BoosterTestTask
//
//  Created by Oleksii Shabalin on 8/9/22.
//

import Foundation

final class CategoryPresenter {

    private weak var view: CategoryViewProtocol?

    private let interactor: CategoryInteractorProtocol
    private let router: CategoryRouterProtocol

    private lazy var viewState = CategoryViewState()

    init(view: CategoryViewProtocol?,
         interactor: CategoryInteractorProtocol,
         router: CategoryRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension CategoryPresenter: CategoryPresenterProtocol {

    func viewDidLoadEvent() {
        loadCategories()
    }

    func viewWillAppearEvent() {
        // TODO: Implement logic if needed.
    }

    func viewWillDisappearEvent() {
        // TODO: Implement logic if needed.
    }
}

private extension CategoryPresenter {

    func loadCategories() {
        view?.showLoadingIndicator(true)
        interactor.getCategories { [weak self] result in
            guard let self = self else { return }

            defer {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    self.view?.showLoadingIndicator(false)
                }
            }

            switch result {
            case .success(let categories):
                self.viewState.categories = categories
                // TODO: Fulfill received data.
            case .failure(let error):
                // TODO: Handle error if needed.
                break
            }
        }
    }
}
