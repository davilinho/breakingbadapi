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
    @StorageDatasource
    private var character: Character?

    override func setUp() {
        super.setUp()
        self.character = Character(chatId: 1,
                                   name: "NAME",
                                   birthday: "1/1/1970",
                                   occupation: ["TEST"],
                                   img: "IMG",
                                   status: "STATUS",
                                   nickName: "NICK",
                                   appearance: [1, 2, 3, 4],
                                   portrayed: "TEST",
                                   category: "breakingBad, betterCallSaul",
                                   betterCallSaulAppearance: [1, 2])
    }

    func testSaveSuccessful() {
        expect(self.character).toNot(beNil())
        expect(self.character?.chatId).to(equal(1))
        expect(self.character?.name).to(equal("NAME"))
        expect(self.character?.birthday).to(equal("1/1/1970"))
        expect(self.character?.occupation).to(equal(["TEST"]))
        expect(self.character?.img).to(equal("IMG"))
        expect(self.character?.status).to(equal("STATUS"))
        expect(self.character?.nickName).to(equal("NICK"))
        expect(self.character?.appearance).to(equal([1, 2, 3, 4]))
        expect(self.character?.portrayed).to(equal("TEST"))
        expect(self.character?.category).to(equal("breakingBad, betterCallSaul"))
        expect(self.character?.betterCallSaulAppearance).to(equal([1, 2]))
    }
}
