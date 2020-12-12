//
//  UseCase.swift
//  breakingbadapi
//
//  Created by David Martin on 12/12/20.
//

import Foundation

class UseCase: InjectableComponent {
    @Inject private var repository: Repository

    func fetchCharacters(completion: @escaping ([Character]) -> Void) {
        DispatchQueue.global(qos: .background).async {
            self.repository.fetchCharacters { response in
                DispatchQueue.main.async {
                    completion(response)
                }
            }
        }
    }
}
