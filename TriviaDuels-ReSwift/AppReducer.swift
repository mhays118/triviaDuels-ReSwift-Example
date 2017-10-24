//
//  AppReducer.swift
//  TriviaDuels-ReSwift
//
//  Created by Marcus Hays on 6/15/17.
//  Copyright © 2017 PKI. All rights reserved.
//

import Foundation
import ReSwift
import ReSwiftRouter

func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(navigationState: NavigationReducer.handleAction(action, state: state?.navigationState),
                    localPlayer: localPlayerReducer(action: action, state: state?.localPlayer),
                    challengers: challengersReducer(action: action, state: state?.challengers),
                    duel: duelReducer(action: action, state: state?.duel, localPlayer: state?.localPlayer))
}

func localPlayerReducer(action: Action, state: Player?) -> Player {
    return state ?? Player(username: "Me")
}

func challengersReducer(action: Action, state: [Player]?) -> [Player] {
    var state = state ?? []
    switch action {
    case let action as SetChallengers:
        switch action.result {
        case .success(let challengers):
            state = challengers
        default: break
        }
    default: break
    }

    return state
}

func duelReducer(action: Action, state: DuelState?, localPlayer: Player?) -> DuelState? {
    switch action {
    case let action as ChallengePlayer:
        guard let localPlayer = localPlayer else { return nil }
        return DuelState(challenger: localPlayer,
                         challenged: action.player,
                         challengerTriva: triviaReducer(action: action, state: state?.challengerTriva))
    case _ as DuelFinished:
        return nil
    default:
        guard let duel = state else { return nil }
        return DuelState(challenger: duel.challenger,
                         challenged: duel.challenged,
                         challengerTriva: triviaReducer(action: action, state: state?.challengerTriva))
    }
}

func triviaReducer(action: Action, state: TriviaState?) -> TriviaState {
    var state = state ?? TriviaState(isFinished: false,
                                questions: [],
                                currentQuestionIndex: nil,
                                numberOfCorrectAnswers: 0)


    switch action {
    case let action as SetQuestions:
        switch action.questionResult {
        case .success(let questions):
            state.questions = questions
            state.currentQuestionIndex = 0
        default: break
        }
    case let action as AnswerQuestion:
        guard let oldIndex = state.currentQuestionIndex else { return state }
        let newIndex = oldIndex + 1
        if newIndex == state.questions.count {
            state.isFinished = true
        } else {
            state.currentQuestionIndex = newIndex
        }
        if state.questions[oldIndex].correctOption == action.answer {
            state.numberOfCorrectAnswers += 1
        }
    default:
        break
    }

    return state
}
