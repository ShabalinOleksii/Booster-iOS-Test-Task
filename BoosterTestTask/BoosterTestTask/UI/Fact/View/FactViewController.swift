//
//  FactViewController.swift
//  BoosterTestTask
//
//  Created by Oleksii Shabalin on 8/10/22.
//

import UIKit

final class FactViewController: UIViewController {

    var presenter: FactPresenterProtocol?

    @IBOutlet private var collectionView: UICollectionView! {
        didSet {
            collectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            collectionView.layer.cornerRadius = 10.0
        }
    }
    @IBOutlet private var pageControlContainer: UIView!

    private var pageControlView: FactFooterView?

    private var collectionViewProvider: FactCollectionViewProviderProtocol?

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

    func setupNavigation(with title: String) {
        navigationItem.title = title
    }

    func setupPageControl() {
        guard let footerView = Bundle.main.loadNibNamed(
            FactFooterView.identifier,
            owner: FactFooterView.self,
            options: nil
        )?.first as? FactFooterView
        else { return }

        pageControlView = footerView
        pageControlContainer.addSubview(footerView)

        footerView.translatesAutoresizingMaskIntoConstraints = false

        footerView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        footerView.layer.cornerRadius = 10.0

        NSLayoutConstraint.activate([
            footerView.topAnchor.constraint(equalTo: pageControlContainer.topAnchor),
            footerView.bottomAnchor.constraint(equalTo: pageControlContainer.bottomAnchor),
            footerView.rightAnchor.constraint(equalTo: pageControlContainer.rightAnchor),
            footerView.leftAnchor.constraint(equalTo: pageControlContainer.leftAnchor)
        ])
    }

    func update(with viewState: FactViewState) {
        DispatchQueue.main.async {
            if self.collectionViewProvider == nil {
                self.collectionViewProvider = FactCollectionViewProvider(
                    collectionView: self.collectionView,
                    viewState: viewState
                )
                self.collectionViewProvider?.presenter = self.presenter
                self.pageControlView?.delegate = self.collectionViewProvider as? FactCollectionViewProvider
            }

            self.collectionViewProvider?.updateCollectionView(with: viewState)
            self.collectionViewProvider?.reloadCollectionView()
        }
    }
}
