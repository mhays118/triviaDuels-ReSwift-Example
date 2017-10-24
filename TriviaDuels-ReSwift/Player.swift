//
//  Player.swift
//  TriviaDuels-ReSwift
//
//  Created by Marcus Hays on 6/7/17.
//  Copyright © 2017 PKI. All rights reserved.
//

import Foundation
import ObjectMapper

struct Player {
    var username: String
}

extension Player: ImmutableMappable {

    init(map: Map) throws {
		username = try map.value("name")
	}

	mutating func mapping(map: Map) {
		username <- map["name"]
	}
}

extension Player: Equatable {
    public static func ==(lhs: Player, rhs: Player) -> Bool {
        return lhs.username == rhs.username
    }
}
