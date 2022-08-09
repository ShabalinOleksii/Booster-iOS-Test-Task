//
//  CategoryViewController.swift
//  BoosterTestTask
//
//  Created by Oleksii Shabalin on 8/9/22.
//

import UIKit

final class CategoryViewController: UIViewController {

    // Test Outlet
    @IBOutlet private var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        APIService.shared.getCategories { result in
            switch result {
            case .success(let categories):
                print("success: \(categories.count)")
            case .failure(let error):
                print("failure: \(error.localizedDescription)")
            }
        }

//        guard
//            let url = URL(string: "https://upload.wikimedia.org/wikipedia/commons/2/2b/WelshCorgi.jpeg")
//        else { return }
//
//        LoadingView.addLoader(to: view)
//
//        APIService.shared.getImage(by: url) { [weak self] image in
//            guard let self = self else { return }
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                LoadingView.removeLoader(from: self.view)
//                self.imageView.image = image
//            }
//        }
    }
}

