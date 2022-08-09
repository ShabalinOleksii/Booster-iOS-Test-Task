//
//  CategoryViewController.swift
//  BoosterTestTask
//
//  Created by Oleksii Shabalin on 8/9/22.
//

import UIKit

final class CategoryViewController: UIViewController {

    var presenter: CategoryPresenterProtocol?

    @IBOutlet private var tableView: UITableView!

    private var tableViewProvider: CategoryTableViewProviderProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoadEvent()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter?.viewWillAppearEvent()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        presenter?.viewWillDisappearEvent()
    }
}

extension CategoryViewController: CategoryViewProtocol {

    func showLoadingIndicator(_ shouldShow: Bool) {
        DispatchQueue.main.async {
            shouldShow
                ? LoadingView.addLoader(to: self.view)
                : LoadingView.removeLoader(from: self.view)
        }
    }

    func update(with viewState: CategoryViewState) {
        DispatchQueue.main.async {
            if self.tableViewProvider == nil {
                self.tableViewProvider = CategoryTableViewProvider(tableView: self.tableView,
                                                                   viewState: viewState)
                self.tableViewProvider?.presenter = self.presenter
            }

            self.tableViewProvider?.updateTableView(with: viewState)
            self.tableViewProvider?.reloadTableView()
        }
    }
}
