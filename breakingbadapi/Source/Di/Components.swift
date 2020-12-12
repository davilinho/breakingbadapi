//
//  Components.swift
//  breakingbadapi
//
//  Created by David Martin on 12/12/20.
//

import Foundation

class Components {
    static func initInjections() {
        Resolver.shared.add(type: RemoteDatasource.self, { return RemoteDatasource() })
        Resolver.shared.add(type: Repository.self, { return Repository() })
        Resolver.shared.add(type: UseCase.self, { return UseCase() })
        Resolver.shared.add(type: ListViewModel.self, { return ListViewModel() })
    }
}
