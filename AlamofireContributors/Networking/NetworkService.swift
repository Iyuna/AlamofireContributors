//
//  NetworkService.swift
//  AlamofireContributors
//
//  Created by Iryna Vasylieva on 9/26/17.
//  Copyright © 2017 Iryna Vasylieva. All rights reserved.
//

import Alamofire

// MARK: - API Protocol
protocol AlamofireContributorsAPI {
    func fetchContributors(completion: @escaping ((_ result: Result<[Contributor]>) -> Void))
    func fetchContributorDetails(for: Contributor,
                                 completion: @escaping ((_ result: Result<ContributorDetails>) -> Void))
}

enum ServiceError: Error {
    case badPayload
    case parse

    var localizedDescription: String {
        switch self {
        case .badPayload:   return localizedString("ErrorBadPayload")
        case .parse:        return localizedString("ErrorParse")
        }
    }
}

/// A service that sends and retrieves requests
class NetworkService {
    private enum Request {
        case fetchContributors
        case fetchContributorDetails(Contributor)

        var baseURL: URL { return URL(string: "https://api.github.com")! }
        var requestSubpath: String {
            switch self {
            case .fetchContributors:
                return "repos/Alamofire/Alamofire/contributors"
            case .fetchContributorDetails(let contributor):
                return URL(string: "users")!.appendingPathComponent(contributor.login).absoluteString
            }
        }
        var requestPath: String {
            return baseURL.appendingPathComponent(requestSubpath).absoluteString
        }
        var alamofireRequest: Alamofire.DataRequest {
            return Alamofire.request(requestPath)
        }
    }
}

extension NetworkService: AlamofireContributorsAPI {
    func fetchContributors(completion: @escaping ((Result<[Contributor]>) -> Void)) {
        Request.fetchContributors.alamofireRequest.responseJSON {
            completion(self.parseJSONResponse($0))
        }
    }

    func fetchContributorDetails(for contributor: Contributor,
                                 completion: @escaping ((_ result: Result<ContributorDetails>) -> Void)) {
        Request.fetchContributorDetails(contributor).alamofireRequest.responseJSON {
            completion(self.parseJSONResponse($0))
        }
    }
}

// MARK: - Private interface
private extension NetworkService {
    func parseJSONResponse<T: JSONInitable>(_ response: Alamofire.DataResponse<Any>) -> Result<T>  {
        if let error = response.error { return .failure(error) }
        guard let responseJSON = response.value as? [String: Any] else {
            return .failure(ServiceError.badPayload)
        }
        if let model = T(json: responseJSON) {
            return .success(model)
        }
        return .failure(ServiceError.parse)
    }

    func parseJSONResponse<T: JSONInitable>(_ response: Alamofire.DataResponse<Any>) -> Result<[T]> {
        if let error = response.error { return .failure(error) }
        guard let responseArray = response.value as? [[String: Any]] else {
            return .failure(ServiceError.badPayload)
        }
        var resultArray = [T]()
        for modelJSON in responseArray {
            if let model = T(json: modelJSON) {
                resultArray.append(model)
            } else {
                return .failure(ServiceError.parse)
            }
        }
        return .success(resultArray)
    }
}
