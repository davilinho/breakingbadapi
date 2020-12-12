//
//  Resolver.swift
//  breakingbadapi
//
//  Created by David Martin on 12/12/20.
//

import Foundation

protocol InjectableComponent: AnyObject {}

class Resolver {
    static let shared = Resolver()

    var factoryDict: [String: () -> InjectableComponent] = [:]

    func add(type: InjectableComponent.Type, _ factory: @escaping () -> InjectableComponent) {
        factoryDict[String(describing: type.self)] = factory
    }

    func resolve<InjectableComponent>(_ type: InjectableComponent.Type) -> InjectableComponent {
        let component: InjectableComponent =
            factoryDict[String(describing: InjectableComponent.self)]?() as! InjectableComponent
        return component
    }
}
