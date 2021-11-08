//
//  BaseError.swift
//  breakingbadapi
//
//  Created by David Martin on 8/12/20.
//

import UIKit

public enum BaseError: Error {
    case repositoryError(RepositoryError)
    case remoteError(RemoteError)
    case ui(UIError)

    public enum RepositoryError {
        case noResponseData
        case localStorageUpToDate
        case reason(String)

        var description: String {
            switch self {
            case let .reason(reason):
                return "Reason: \(reason)"
            default:
                return String(describing: self)
            }
        }
    }

    public enum RemoteError {
        case httpUrlResponse(HTTPURLResponse)
        case code(Int)
        case reason(String)

        var description: String {
            switch self {
            case let .reason(reason):
                return "Reason: \(reason)"
            default:
                return String(describing: self).capitalizingFirstLetter()
            }
        }
    }

    public enum UIError {
        case cantLoad
        case notResponds
        case notFound
        case reason(String)

        var description: String {
            switch self {
            case let .reason(reason):
                return "Reason: \(reason)"
            default:
                return String(describing: self).capitalizingFirstLetter()
            }
        }
    }

    var description: String {
        switch self {
        case let .repositoryError(error):
            return "RepositoryError - " + error.description
        case let .remoteError(error):
            return "RemoteError - " + error.description
        case let .ui(error):
            return "UIError - " + error.description
        }
    }
}

extension BaseError: Equatable {
    public static func == (lhs: BaseError, rhs: BaseError) -> Bool {
        return lhs.description == rhs.description
    }
}

private extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
