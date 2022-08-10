//
//  FactViewController.swift
//  BoosterTestTask
//
//  Created by Oleksii Shabalin on 8/10/22.
//

import UIKit

final class FactViewController: UIViewController {

    weak var presenter: FactPresenterProtocol?

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

extension FactViewController: FactViewProtocol {

    func update(with viewState: FactViewState) {
        // TODO: Implement logic if needed.
    }
}
