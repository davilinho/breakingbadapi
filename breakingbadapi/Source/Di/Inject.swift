//
//  Inject.swift
//  breakingbadapi
//
//  Created by David Martin on 12/12/20.
//

import Foundation

@propertyWrapper
struct Inject<Component>{
    var component: Component

    init() {
        self.component = Resolver.shared.resolve(Component.self)
    }

    public var wrappedValue: Component {
        get { return component }
        mutating set { component = newValue }
    }
}
