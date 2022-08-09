//
//  CategoryViewController.swift
//  BoosterTestTask
//
//  Created by Oleksii Shabalin on 8/9/22.
//

import UIKit

final class CategoryViewController: UIViewController {

    var presenter: CategoryViewDelegate?

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
}
