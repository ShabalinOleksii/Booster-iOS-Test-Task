//
//  FactPresenter.swift
//  BoosterTestTask
//
//  Created by Oleksii Shabalin on 8/10/22.
//

import Foundation

final class FactPresenter {

    private weak var view: FactViewProtocol?

    private let interactor: FactInteractorProtocol
    private let router: FactRouterProtocol

    private lazy var viewState = FactViewState()

    init(view: FactViewProtocol?,
         interactor: FactInteractorProtocol,
         router: FactRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension FactPresenter: FactPresenterProtocol {

    func viewDidLoadEvent() {
        viewState.facts = interactor.entity.facts
        view?.update(with: viewState)
    }

    func viewWillAppearEvent() {
        // TODO: Implement logic if needed.
    }

    func viewWillDisappearEvent() {
        // TODO: Implement logic if needed.
    }
}
