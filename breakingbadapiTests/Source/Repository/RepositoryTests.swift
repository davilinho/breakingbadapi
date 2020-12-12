//
//  RepositoryTests.swift
//  breakingbadapiTests
//
//  Created by David Martin on 12/12/20.
//

@testable import breakingbadapi
import XCTest
import Nimble

class RepositoryTests: XCTestCase {

    @Inject private var repository: Repository

    func testRepositoryNotNil() {
        expect(self.repository).toNot(beNil())
    }

    func testFetchCharacters() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            self.repository.fetchCharacters { response in
                expect(response).toNot(beNil())
                expect(response.count).to(beGreaterThan(0))
                done()
            }
        }
    }
}
