//
//  Action.swift
//  TriviaDuels-ReSwift
//
//  Created by Marcus Hays on 6/15/17.
//  Copyright © 2017 PKI. All rights reserved.
//

import Foundation
import ReSwift

func fetchChallengers(state: AppState, store: Store<AppState>) -> Action? {
    TriviaService.getChallengers { result in
        store.dispatch(SetChallengers(result: result))
    }
    return nil
}

struct SetChallengers: Action {
    let result: APIResult<[Player]>
}

struct ChallengePlayer: Action {
    let player: Player
}

func fetchQuestions(state: AppState, store: Store<AppState>) -> Action? {
    TriviaService.getTriviaQuestions { result in
        store.dispatch(SetQuestions(questionResult: result))
    }
    return nil
}

struct SetQuestions: Action {
    let questionResult: APIResult<[Question]>
}

struct AnswerQuestion: Action {
    let answer: Int
}

struct DuelFinished: Action {}
