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

    func onViewDidLoad() {
        self.useCase.fetchCharacters { [weak self] in
            guard let self = self else { return }
            self.update(models: $0)
        }
    }

    func search(by name: String) {
        self.useCase.fetchCharacters(by: name) { [weak self] in
            guard let self = self else { return }
            self.update(models: $0)
        }
    }

    private func update(models: [Character]) {
        self.characters.value = models
    }
}
