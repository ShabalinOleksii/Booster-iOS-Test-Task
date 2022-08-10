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

// MARK: - CategoryViewDelegate
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

// MARK: - CategoryPresenterActionHandler
extension CategoryPresenter: CategoryPresenterActionHandler {

    func didSelectCategory(with identifier: Int) {
        guard
            let category = viewState.categories.first(where: { $0.order == identifier }),
            !category.content.isEmpty && category.status != .undefined
        else { return }

        let entity = FactEntity(categoryTitle: category.title, facts: category.content)
        router.show(.facts(entity: entity))
    }
}

// MARK: - Private Extension
private extension CategoryPresenter {

    func loadCategories() {
        view?.showLoadingIndicator(true)
        interactor.getCategories { [weak self] result in
            guard let self = self else { return }

            defer {
                // Added delay to show the way loading indicator works.
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.view?.showLoadingIndicator(false)
                }
            }

            switch result {
            case .success(let categories):
                self.viewState.categories = categories.sorted(by: { $0.order < $1.order })
                self.view?.update(with: self.viewState)
            case .failure(let error):
                // TODO: Handle error if needed.
                break
            }
        }
    }
}
