//
//  ListViewControllerTests.swift
//  breakingbadapiTests
//
//  Created by David Martin on 12/12/20.
//

@testable import breakingbadapi
import XCTest
import Nimble
import SnapshotTesting

class ListViewControllerTests: XCTestCase {
    let spy: ListViewModelMock = ListViewModelMock()

    func testViewControllerDidLoad() {
        guard let sut = self.loadView() else { return }
        sut.viewDidLoad()
        expect(self.spy.onViewLoadedCalled).to(beTrue())
    }

    func testViewControllerAssertSnapshotSuccessful() {
        guard let sut = self.loadView() else { return }
        assertSnapshot(matching: sut, as: .image)
    }
}

extension ListViewControllerTests {
    private func loadView() -> ListViewController? {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "List", bundle: bundle)
        guard let sut: ListViewController = storyboard.instantiateViewController(withIdentifier: "List") as? ListViewController else { return nil }
        sut.viewModel = spy
        return sut
    }
}
