//
//  GetChallengersService.swift
//  TriviaDuels-ReSwift
//
//  Created by Marcus Hays on 6/7/17.
//  Copyright © 2017 PKI. All rights reserved.
//

import Alamofire

struct GetChallengersRequest: TriviaRequestable {
    let method: HTTPMethod = .get
    let path: String = "/challengers"
}
