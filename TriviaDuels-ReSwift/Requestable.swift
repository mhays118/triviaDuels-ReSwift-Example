//
//  Requestable.swift
//  Punchkick Interactive
//
//  Created by Marcus Hays on 4/10/17.
//  Copyright © 2017 Punchkick Interactive. All rights reserved.
//

import Foundation
import Alamofire

protocol Requestable: URLRequestConvertible {
    var method: HTTPMethod { get }
    var params: Parameters? { get }
    var headers: HTTPHeaders? { get }
    var path: String { get }
}

//Make these properties optional
extension Requestable {
    var params: Parameters? { return nil }
    var headers: HTTPHeaders? { return nil }
}
