//
//  UseCaseTests.swift
//  breakingbadapiTests
//
//  Created by David Martin on 12/12/20.
//

@testable import breakingbadapi
import XCTest
import Nimble

class UseCaseTests: XCTestCase {

    @Inject private var useCase: UseCase

    func testUseCaseNotNil() {
        expect(self.useCase).toNot(beNil())
    }

    func testFetchCharacters() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            self.useCase.fetchCharacters { response in
                expect(response).toNot(beNil())
                expect(response.count).to(beGreaterThan(0))
                done()
            }
        }
    }
}
