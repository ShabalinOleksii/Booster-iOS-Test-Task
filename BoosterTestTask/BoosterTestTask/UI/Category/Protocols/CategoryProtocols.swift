//
//  CategoryProtocols.swift
//  BoosterTestTask
//
//  Created by Oleksii Shabalin on 8/9/22.
//

import Foundation

enum CategoryDestination {
    case facts
}

// MARK: - Router
protocol CategoryRouterProtocol: AnyObject {
    func show(_ destination: CategoryDestination)
}

// MARK: - View
protocol CategoryViewProtocol: AnyObject {
    func showLoadingIndicator(_ shouldShow: Bool)
}

protocol CategoryViewDelegate: AnyObject {
    func viewDidLoadEvent()
    func viewWillAppearEvent()
    func viewWillDisappearEvent()
}

// MARK: - Interactor
protocol CategoryInteractorProtocol {
    func getCategories(completion: @escaping (Swift.Result<[CategoryModel], Error>) -> Void)
}

// MARK: - Presenter
protocol CategoryPresenterProtocol: CategoryViewDelegate { }
