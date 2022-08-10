//
//  FactRouter.swift
//  BoosterTestTask
//
//  Created by Oleksii Shabalin on 8/10/22.
//

import Foundation

// TODO: Extend if needed.
final class FactRouter {

    var viewController: FactViewController

    init(viewController: FactViewController) {
        self.viewController = viewController
    }
}

extension FactRouter: FactRouterProtocol { }
