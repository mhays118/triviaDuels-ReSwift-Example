//
//  TriviaServiceError.swift
//  TriviaDuels-ReSwift
//
//  Created by Marcus Hays on 6/7/17.
//  Copyright © 2017 PKI. All rights reserved.
//

import Foundation

enum TriviaServiceError: Error {
    case unknown, serviceFailed, invalidRequest, noData

    var description: String {
        switch self {
        case .serviceFailed: return "Something went wrong"
        case .invalidRequest: return "Request was not valid"
        case .unknown: return "An unknown error has occurred"
        case .noData: return "No data found"
        }
    }

    static func error(for statusCode: Int) -> TriviaServiceError {
        switch statusCode {
        case 400: return .invalidRequest
        case 500: return .serviceFailed
        default: return .unknown
        }
    }
}
