//
//  StorageDatasource.swift
//  breakingbadapi
//
//  Created by David Martin on 12/12/20.
//

import Foundation

@propertyWrapper
struct StorageDatasource<T> {
    private let key: String
    private let defaultValue: T

    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get { return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue }
        set { UserDefaults.standard.set(newValue, forKey: key) }
    }
}
