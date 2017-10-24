//
//  GetTriviaQuestionsService.swift
//  TriviaDuels-ReSwift
//
//  Created by Marcus Hays on 6/7/17.
//  Copyright © 2017 PKI. All rights reserved.
//

import Alamofire

//TODO: Unused right now
struct GetTriviaQuestionsRequest: TriviaRequestable {
    let method: HTTPMethod = .get
    let path: String = "/trivia"
}
