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
            self?.characters.value = $0
        }
    }
}
