//
//  RemoteDastasource.swift
//  breakingbadapi
//
//  Created by David Martin on 8/12/20.
//

import Alamofire

class RemoteDatasource: InjectableComponent {
    private let baseUrl: String = "https://www.breakingbadapi.com/api"

    private let sessionManager: Session = {
      let configuration = URLSessionConfiguration.default
      configuration.timeoutIntervalForRequest = 30
      configuration.requestCachePolicy = .returnCacheDataElseLoad
      return Session(configuration: configuration)
    }()
}

extension RemoteDatasource {
    func get<Response: Codable>(to endpoint: String, with params: String?, completion: @escaping (Result<Response, BaseError>) -> Void) {
        let url: String = [self.baseUrl, endpoint].compactMap { $0 }.joined(separator: "/")
        let request = params?.dictionary

        CoreLog.remote.debug("Request: %@", url.description)

        self.sessionManager
            .request(url, method: .get,
                     parameters: request,
                     encoding: JSONEncoding.default,
                     headers: ["Accept": "application/json",
                               "Content-Type": "application/json"])
            .validate(contentType: ["application/json"])
            .responseDecodable(of: Response.self) { response in
                guard let data = response.data, let stringResponse: String = String(data: data, encoding: .utf8) else {
                    completion(.failure(.remoteError(.reason(response.error?.errorDescription ?? "Networking error connection"))))
                    return
                }
                guard let statusCode = response.response?.statusCode else {
                    completion(.failure(.remoteError(.reason("Wrong response received: \(response.error?.errorDescription ?? "Wrong status response code received")"))))
                    return
                }
                guard statusCode >= 200, statusCode < 300 else {
                    completion(.failure(.remoteError(.reason("Wrong response received: \(statusCode)"))))
                    return
                }

                CoreLog.remote.debug("Response: %@", stringResponse)

                switch response.result {
                case let .success(data):
                    completion(.success(data))
                case let .failure(error):
                    completion(.failure(.remoteError(.reason(error.localizedDescription))))
                }
            }
    }
}
