//
//  StorageDatasourceTests.swift
//  breakingbadapiTests
//
//  Created by David Martin on 12/12/20.
//

@testable import breakingbadapi
import XCTest
import Nimble

class StorageDatasourceTests: XCTestCase {
    @StorageDatasource("test", defaultValue: false)
    private var storage: Bool

    func testSaveSuccessful() {
        storage = true
        expect(self.storage).to(beTrue())
    }
}
