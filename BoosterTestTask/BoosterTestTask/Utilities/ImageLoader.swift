//
//  ImageLoader.swift
//  BoosterTestTask
//
//  Created by Oleksii Shabalin on 8/10/22.
//

import UIKit

protocol ImageLoaderProtocol: AnyObject {
    func loadImage(by url: URL, completion: @escaping (UIImage?) -> Void)
}

final class ImageLoader {

    // MARK: - Singletone
    static let shared = ImageLoader()

    private init() { }

}

// MARK: - ImageLoaderProtocol
extension ImageLoader: ImageLoaderProtocol {

    func loadImage(by url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                DispatchQueue.main.async { completion(UIImage(data: data)) }
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}
