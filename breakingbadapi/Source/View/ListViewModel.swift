//
//  ListViewModel.swift
//  breakingbadapi
//
//  Created by David Martin on 6/12/20.
//

import Foundation

class ListViewModel: InjectableComponent & BaseViewModel {
    @Inject private var useCase: UseCase

    var characters = Observable<[Character]>()
    var isAnimated = Observable<Bool>()

    func onViewDidLoad() {
        self.useCase.fetchCharacters { [weak self] in
            self?.characters.value = $0
        }
    }

    func startAnimation() {
        self.isAnimated.value = true
    }

    func stopAnimation() {
        self.isAnimated.value = false
    }
}
