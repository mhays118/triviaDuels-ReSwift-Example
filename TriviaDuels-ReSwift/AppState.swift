//
//  AppState.swift
//  TriviaDuels-ReSwift
//
//  Created by Marcus Hays on 6/15/17.
//  Copyright © 2017 PKI. All rights reserved.
//

import Foundation
import ReSwift
import ReSwiftRouter

struct AppState: StateType, HasNavigationState {
    var navigationState: NavigationState
    var localPlayer: Player
    var challengers: [Player]
    var duel: DuelState?
}

struct DuelState: StateType {
    var challenger: Player
    var challenged: Player
    var challengerTriva: TriviaState
}

struct TriviaState: StateType {
    var isFinished: Bool
    var questions: [Question]
    var currentQuestionIndex: Int?
    var numberOfCorrectAnswers: Int
}

extension TriviaState: Equatable {
    static func ==(lhs: TriviaState, rhs: TriviaState) -> Bool {
        return lhs.isFinished == rhs.isFinished && rhs.questions == lhs.questions && lhs.currentQuestionIndex == rhs.currentQuestionIndex && lhs.numberOfCorrectAnswers == rhs.numberOfCorrectAnswers
    }
}
