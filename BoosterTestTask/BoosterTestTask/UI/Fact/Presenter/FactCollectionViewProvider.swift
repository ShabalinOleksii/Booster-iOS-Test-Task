//
//  FactCollectionViewProvider.swift
//  BoosterTestTask
//
//  Created by Oleksii Shabalin on 8/10/22.
//

import UIKit

private enum ScrollDirection {
    case left
    case right
}

protocol FactCollectionViewProviderProtocol: AnyObject {
    var presenter: FactPresenterProtocol? { get set }

    func updateCollectionView(with viewState: FactViewState)
    func reloadCollectionView()
}

protocol FactCollectionViewProviderDelegate: AnyObject { }

final class FactCollectionViewProvider: NSObject {

    weak var presenter: FactPresenterProtocol?

    private let collectionView: UICollectionView
    private let collectionViewLayout = UICollectionViewFlowLayout()
    private var viewState: FactViewState

    private var currentStep: Int = 0

    init(collectionView: UICollectionView, viewState: FactViewState) {
        self.collectionView = collectionView
        self.viewState = viewState

        super.init()

        self.setupCollectionView()
    }
}

// MARK: - FactCollectionViewProviderProtocol
extension FactCollectionViewProvider: FactCollectionViewProviderProtocol {

    func updateCollectionView(with viewState: FactViewState) {
        self.viewState = viewState
    }

    func reloadCollectionView() {
        collectionView.reloadData()
    }
}

// MARK: - FactFooterViewDelegate
extension FactCollectionViewProvider: FactFooterViewDelegate {

    func showPreviousFact() {
        guard currentStep > 0 else { return }

        currentStep -= 1
        scrollTo(currentStep)
    }

    func showNextFact() {
        guard currentStep < viewState.facts.count - 1 else { return }

        currentStep += 1
        scrollTo(currentStep)
    }
}

// MARK: - UIScrollViewDelegate
extension FactCollectionViewProvider: UIScrollViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentStep = retrieveStep(from: scrollView)
    }
}

// MARK: - UICollectionViewDataSource
extension FactCollectionViewProvider: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewState.facts.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeuedFactCell(for: indexPath)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension FactCollectionViewProvider: UICollectionViewDelegate { }

// MARK: - UICollectionViewDelegateFlowLayout
extension FactCollectionViewProvider: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width,
                      height: collectionView.frame.height)
    }
}

// MARK: - Register & Dequeue Cells
private extension FactCollectionViewProvider {

    func setupCollectionView() {
        collectionViewLayout.sectionInset = UIEdgeInsets.zero
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumLineSpacing = 0

        collectionView.collectionViewLayout = collectionViewLayout

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.decelerationRate = .normal
        collectionView.isPagingEnabled = true

        registerNibs()
    }

    func registerNibs() {
        let reuseIdsCellTypes: [String] = [FactCell.identifier]

        reuseIdsCellTypes.forEach { identifier in
            let cellNib = UINib(nibName: identifier, bundle: nil)
            collectionView.register(cellNib, forCellWithReuseIdentifier: identifier)
        }
    }

    func dequeuedFactCell(for indexPath: IndexPath) -> FactCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FactCell.identifier,
                                                          for: indexPath) as? FactCell
        else { fatalError("`FactCell` hasn't been found") }

        cell.configure(with: viewState.facts[indexPath.row])

        return cell
    }
}

// MARK: - Helpers
private extension FactCollectionViewProvider {

    func retrieveStep(from scrollView: UIScrollView) -> Int {
        return Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
    }

    private func scrollTo(_ step: Int) {
        guard
            step < collectionView.numberOfItems(inSection: 0)
        else { return }

        collectionView.scrollToItem(at: IndexPath(row: step, section: 0),
                                    at: .centeredHorizontally,
                                    animated: false)
    }
}
