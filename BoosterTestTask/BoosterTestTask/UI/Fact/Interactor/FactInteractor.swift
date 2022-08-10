//
//  FactInteractor.swift
//  BoosterTestTask
//
//  Created by Oleksii Shabalin on 8/10/22.
//

import Foundation

final class FactInteractor {

    private(set) var entity: FactEntity

    init(entity: FactEntity) {
        self.entity = entity
    }
}

extension FactInteractor: FactInteractorProtocol { }
