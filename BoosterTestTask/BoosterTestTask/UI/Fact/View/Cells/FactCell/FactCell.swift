//
//  FactCell.swift
//  BoosterTestTask
//
//  Created by Oleksii Shabalin on 8/10/22.
//

import UIKit

final class FactCell: UICollectionViewCell {

    static let identifier = String(describing: FactCell.self)

    @IBOutlet private var icon: UIImageView! {
        didSet {
            icon.layer.cornerRadius = 8.0
        }
    }
    @IBOutlet private var title: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        icon.image = nil
        title.text = nil
    }

    func configure(with fact: FactModel) {
        if let url = URL(string: fact.image) {
            ImageLoader.shared.loadImage(by: url) { [weak self] image in
                DispatchQueue.main.async {
                    self?.icon.image = image
                }
            }
        }
        title.text = fact.fact
    }
}
