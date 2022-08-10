//
//  CategoryTableViewProvider.swift
//  BoosterTestTask
//
//  Created by Oleksii Shabalin on 8/9/22.
//

import UIKit

protocol CategoryTableViewProviderProtocol: AnyObject {
    var presenter: CategoryPresenterProtocol? { get set }

    func updateTableView(with viewState: CategoryViewState)
    func reloadTableView()
}

protocol CategoryTableViewProviderDelegate: AnyObject { }

final class CategoryTableViewProvider: NSObject {

    weak var presenter: CategoryPresenterProtocol?

    private let tableView: UITableView
    private var viewState: CategoryViewState

    init(tableView: UITableView, viewState: CategoryViewState) {
        self.tableView = tableView
        self.viewState = viewState

        super.init()

        self.setupTableView()
    }
}

// MARK: - CategoryTableViewProviderProtocol
extension CategoryTableViewProvider: CategoryTableViewProviderProtocol {

    func updateTableView(with viewState: CategoryViewState) {
        self.viewState = viewState
    }

    func reloadTableView() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension CategoryTableViewProvider: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewState.categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeuedCategoryCell(for: indexPath)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CategoryTableViewProvider: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectCategory(with: viewState.categories[indexPath.row].order)
    }
}

// MARK: - Register & Dequeue Cells
private extension CategoryTableViewProvider {

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.separatorStyle = .none

        registerNibs()
    }

    func registerNibs() {
        let reuseIdsCellTypes: [String] = [CategoryCell.identifier]

        reuseIdsCellTypes.forEach { identifier in
            let cellNib = UINib(nibName: identifier, bundle: nil)
            tableView.register(cellNib, forCellReuseIdentifier: identifier)
        }
    }

    func dequeuedCategoryCell(for indexPath: IndexPath) -> CategoryCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier,
                                                     for: indexPath) as? CategoryCell
        else { fatalError("`CategoryCell` hasn't been found") }

        cell.configure(with: viewState.categories[indexPath.row])

        return cell
    }
}
