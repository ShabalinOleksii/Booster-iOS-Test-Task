//
//  LoadingView.swift
//  BoosterTestTask
//
//  Created by Oleksii Shabalin on 8/9/22.
//

import UIKit

private enum Constants {

    static let loadingViewId = 999
}

final class LoadingView: UIView {

    private static func defaultLoadingView() -> Self {
        let screenRect = UIScreen.main.bounds
        let mainViewRect = CGRect(origin: CGPoint(x: 0, y: 0), size: screenRect.size)

        return Self.init(frame: mainViewRect)
    }

    private override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    @available(*, unavailable)
    internal required init?(coder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }
}

// MARK: - Public Interface
extension LoadingView {

    static func addLoader(to view: UIView) {
        guard
            view.viewWithTag(Constants.loadingViewId) as? LoadingView == nil
        else { return }

        let loadingView = LoadingView.defaultLoadingView()

        view.addSubview(loadingView)
        view.bringSubviewToFront(loadingView)
    }

    static func removeLoader(from view: UIView) {
        guard
            let loadingView = view.viewWithTag(Constants.loadingViewId) as? LoadingView
        else { return }

        loadingView.removeFromSuperview()
    }
}

// MARK: - View Configuration
private extension LoadingView {

    func configure() {
        tag = Constants.loadingViewId

        let spinner = UIActivityIndicatorView(style: .large)

        spinner.frame = frame
        spinner.color = .gray
        spinner.startAnimating()
        spinner.isHidden = isHidden

        self.addSubview(spinner)
    }
}
