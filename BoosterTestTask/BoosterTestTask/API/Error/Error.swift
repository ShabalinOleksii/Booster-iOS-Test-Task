//
//  CategoryError.swift
//  BoosterTestTask
//
//  Created by Oleksii Shabalin on 8/9/22.
//

import Foundation

// MARK: - Error Protocols
private let errorDomain = "ErrorDomain"

private protocol ErrorLocalizedTitleProtocol {
    var localizedTitle: String { get }
}

private protocol ErrorLocalizedDescriptionProtocol {
    var localizedDescription: String { get }
}

private protocol ErrorCodeProtocol {
    var errorCode: Int { get }
}

private protocol ErrorKeyProtocol {
    var errorKey: String { get }
}

// MARK: - Error Types
enum CategoryErrorType {
    case `internal`(InternalError)
    case unknown

    enum InternalError: Int {
        case invalidURL
        case decodeFailure
        case storageException
    }
}

extension CategoryErrorType: ErrorLocalizedTitleProtocol {

    var localizedTitle: String {
        return "ERROR!"
    }
}

extension CategoryErrorType: ErrorLocalizedDescriptionProtocol {

    var localizedDescription: String {
        switch self {
        case .internal(let error):
            return internalLocalizedDescription(from: error)
        case .unknown:
            return "Unknown error"
        }
    }

    private func internalLocalizedDescription(from error: CategoryErrorType.InternalError) -> String {
        switch error {
        case .invalidURL:
            return "Provided URL is invalid"
        case .decodeFailure:
            return "Model decoding has failed"
        case .storageException:
            return "Couldn't find or read file by path"
        }
    }
}

extension CategoryErrorType: ErrorCodeProtocol {

    var errorCode: Int {
        switch self {
        case .internal(let error):
            return internalErrorCode(from: error)
        case .unknown:
            return -1
        }
    }

    func internalErrorCode(from error: CategoryErrorType.InternalError) -> Int {
        return error.rawValue
    }
}

// MARK: - NSError
final class CategoryError: NSError {

    private(set) var type: CategoryErrorType

    init(type: CategoryErrorType) {
        self.type = type
        super.init(domain: errorDomain,
                   code: type.errorCode,
                   userInfo: [NSLocalizedDescriptionKey: type.localizedDescription])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
