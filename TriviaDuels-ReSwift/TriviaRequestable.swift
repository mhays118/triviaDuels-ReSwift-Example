//
//  TriviaRequestable.swift
//  TriviaDuels-ReSwift
//
//  Created by Marcus Hays on 6/7/17.
//  Copyright © 2017 PKI. All rights reserved.
//

import Foundation
import Alamofire

protocol TriviaRequestable: Requestable {
    var baseURL: URL { get }
}

extension TriviaRequestable {
    var baseURL: URL {
        let urlString = "https://test-triviaduel-api.pkiapps.com"
        return URL(string: urlString)!
    }

    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        let request = try URLRequest(url: url, method: method, headers: headers)

        return try Alamofire.URLEncoding().encode(request, with: params)
    }
}
