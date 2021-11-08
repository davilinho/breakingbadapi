//
//  Repository.swift
//  breakingbadapi
//
//  Created by David Martin on 8/12/20.
//

class Repository: InjectableComponent {
    @Inject private var remote: RemoteDatasource

    func fetchCharacters(by name: String? = nil, completion:  @escaping ([Character]) -> Void) {
        self.remote.get(to: "characters", with: Character(name: name)) { (result: Result<[Character], BaseError>) in
            switch result {
            case .success(let response):
                CoreLog.business.info("%@", response)
                completion(response)
            case .failure(let error):
                CoreLog.business.error("%@", error.description)
            }
        }
    }
}
