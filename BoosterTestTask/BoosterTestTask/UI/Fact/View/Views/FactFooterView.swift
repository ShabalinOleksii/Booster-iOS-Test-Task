//
//  FactFooterView.swift
//  BoosterTestTask
//
//  Created by Oleksii Shabalin on 8/10/22.
//

import UIKit

protocol FactFooterViewDelegate: AnyObject {
    func showPreviousFact()
    func showNextFact()
}

final class FactFooterView: UIView {

    static let identifier = String(describing: FactFooterView.self)

    weak var delegate: FactFooterViewDelegate?

    @IBOutlet private var previousButton: UIButton! {
        didSet {
            previousButton.layer.cornerRadius = previousButton.frame.size.height / 2
        }
    }
    @IBOutlet private var nextButton: UIButton! {
        didSet {
            nextButton.layer.cornerRadius = nextButton.frame.size.height / 2
        }
    }

    @IBAction private func tapOnPrevious(_ sender: Any) {
        delegate?.showPreviousFact()
    }

    @IBAction private func tapOnNext(_ sender: Any) {
        delegate?.showNextFact()
    }
}
