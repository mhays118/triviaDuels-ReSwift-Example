//
//  TriviaService.swift
//  TriviaDuels-ReSwift
//
//  Created by Marcus Hays on 6/7/17.
//  Copyright © 2017 PKI. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

struct TriviaService {
    fileprivate static let manager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData

        return SessionManager(configuration: configuration)
    }()
    
}

extension TriviaService {
    static func getTriviaQuestions(completion: @escaping (APIResult<[Question]>) -> Void) {
        manager.request(GetTriviaQuestionsRequest()).responseArray(keyPath: "questions") { (response: DataResponse<[Question]>) in
            switch response.result {
            case .success(let data):
                let statusCode = response.response?.statusCode ?? 200
                if statusCode == 200 {
                    completion(.success(data))
                } else {
                    completion(.failure(TriviaServiceError.error(for: statusCode)))
                }
                break
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    static func getChallengers(completion: @escaping (APIResult<[Player]>) -> Void) {
        manager.request(GetChallengersRequest()).responseArray { (response: DataResponse<[Player]>) in
            switch response.result {
            case .success(let data):
                let statusCode = response.response?.statusCode ?? 200
                if statusCode == 200 {
                    completion(.success(data))
                } else {
                    completion(.failure(TriviaServiceError.error(for: statusCode)))
                }
                break
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
