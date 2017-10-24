//
//  Result.swift
//  Punchkick Interactive
//
//  Created by Marcus Hays on 4/10/17.
//  Copyright © 2017 Punchkick Interactive. All rights reserved.
//

import Foundation

enum APIResult<Value> {
    case success(Value)
    case failure(Error)
}
