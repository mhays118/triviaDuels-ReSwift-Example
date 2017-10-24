//
//  RequestStatus.swift
//  Tribune
//
//  Created by Marcus Hays on 4/29/17.
//  Copyright © 2017 Punchkick Interactive. All rights reserved.
//

import Foundation

enum RequestStatus: Equatable {
    case uninitiated, finished, loading, error(Error), noData

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    static func ==(lhs: RequestStatus, rhs: RequestStatus) -> Bool {
        switch (lhs, rhs) {
        case (.uninitiated, .uninitiated): return true
        case (.finished, .finished): return true
        case (.loading, .loading): return true
        case (.noData, .noData): return true
        case ( .error(_), .error(_)): return true
        default: return false
        }
    }
}
