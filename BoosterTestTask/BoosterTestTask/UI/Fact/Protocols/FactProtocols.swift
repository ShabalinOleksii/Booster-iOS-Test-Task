//
//  FactProtocols.swift
//  BoosterTestTask
//
//  Created by Oleksii Shabalin on 8/10/22.
//

import Foundation

// MARK: - Router
protocol FactRouterProtocol: AnyObject { }

// MARK: - View
protocol FactViewProtocol: AnyObject {
    func update(with viewState: FactViewState)
}

protocol FactViewDelegate: AnyObject {
    func viewDidLoadEvent()
    func viewWillAppearEvent()
    func viewWillDisappearEvent()
}

// MARK: - Interactor
protocol FactInteractorProtocol {
    var entity: FactEntity { get }
}

// MARK: - Presenter
protocol FactPresenterProtocol: FactViewDelegate { }
