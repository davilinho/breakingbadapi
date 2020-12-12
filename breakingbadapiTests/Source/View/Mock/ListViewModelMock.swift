//
//  ListViewModelMock.swift
//  breakingbadapiTests
//
//  Created by David Martin on 12/12/20.
//

@testable import breakingbadapi
import Foundation

class ListViewModelMock: ListViewModel {
    private(set) var onViewLoadedCalled = false

    override func onViewDidLoad() {
        onViewLoadedCalled = true
    }
}
