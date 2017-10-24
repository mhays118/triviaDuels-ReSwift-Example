//
//  Question.swift
//  TriviaDuels-ReSwift
//
//  Created by Marcus Hays on 6/7/17.
//  Copyright © 2017 PKI. All rights reserved.
//

import Foundation
import ObjectMapper

struct Question {
    var prompt: String
    var options: [String]
    var correctOption: Int
}

extension Question: ImmutableMappable {

	 init(map: Map) throws {
		prompt               = try map.value("question")
		options              = try map.value("answers")
		correctOption        = try map.value("correct")
	}

	mutating func mapping(map: Map) {
		prompt               <- map["question"]
		options              <- map["answers"]
		correctOption        <- map["correct"]
	}
}

extension Question: Equatable {
    static func ==(lhs: Question, rhs: Question) -> Bool {
        return lhs.prompt == rhs.prompt
    }
}
