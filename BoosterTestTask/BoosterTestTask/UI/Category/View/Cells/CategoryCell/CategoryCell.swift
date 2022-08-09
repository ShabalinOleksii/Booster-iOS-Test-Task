//
//  CategoryCell.swift
//  BoosterTestTask
//
//  Created by Oleksii Shabalin on 8/9/22.
//

import UIKit

final class CategoryCell: UITableViewCell {

    static let identifier = String(describing: CategoryCell.self)

    @IBOutlet private var icon: UIImageView!
    @IBOutlet private var title: UILabel!
    @IBOutlet private var subtitle: UILabel!
    @IBOutlet private var status: UILabel!

    @IBOutlet private var blur: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        icon.image = nil
        title.text = nil
        subtitle.text = nil
        status.text = nil
        blur.isHidden = true
    }

    func configure(with category: CategoryModel) {
        if let url = URL(string: category.image) {
            ImageLoader.shared.loadImage(by: url) { [weak self] image in
                DispatchQueue.main.async {
                    self?.icon.image = image
                }
            }
        }
        title.text = category.title
        subtitle.text = category.description

        switch category.status {
        case .free:
            blur.isHidden = true
            status.isHidden = true
        case .paid:
            blur.isHidden = true
            status.isHidden = false
            status.text = category.status.name
        case .undefined:
            blur.isHidden = false
            status.isHidden = true
        }
    }
}
