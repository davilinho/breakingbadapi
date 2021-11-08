//
//  Collection+Safe.swift
//  breakingbadapi
//
//  Created by David Martin on 12/12/20.
//

import Foundation

extension Collection {
    public subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
