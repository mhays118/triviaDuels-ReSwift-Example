//
//  MainViewRoutable.swift
//  Tribune
//
//  Created by Marcus Hays on 4/29/17.
//  Copyright © 2017 Punchkick Interactive. All rights reserved.
//

import Foundation
import ReSwiftRouter

class MainViewRoutable: Routable {

    let navController: NavigationController

    init(_ navController: NavigationController) {
        self.navController = navController
    }

    func pushRouteSegment(
        _ routeElementIdentifier: RouteElementIdentifier,
        animated: Bool,
        completionHandler: @escaping RoutingCompletionHandler) -> Routable
    {
        if routeElementIdentifier == Routes.trivia.value {
            let controller = TriviaController()
            navController.pushViewController(controller, animated: true)
            completionHandler()
            return self
        } else if routeElementIdentifier == Routes.finished.value {
            let numCorrect = store.state.duel?.challengerTriva.numberOfCorrectAnswers ?? 0
            let numQuestions = store.state.duel?.challengerTriva.questions.count ?? 0
            let message = "You got \(numCorrect) out of \(numQuestions) correct"
            let alert = UIAlertController(title: "Trivia Complete", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                store.dispatch(DuelFinished())
                store.dispatch(SetRouteAction([]))
            }))
            navController.rootViewController.present(alert, animated: true)
            completionHandler()
            return self
        }


        fatalError("Cannot handle this route change!")
    }

    func changeRouteSegment(
        _ from: RouteElementIdentifier,
        to: RouteElementIdentifier,
        animated: Bool,
        completionHandler: @escaping RoutingCompletionHandler) -> Routable
    {
        fatalError("Cannot handle this route change!")
    }

    func popRouteSegment(
        _ routeElementIdentifier: RouteElementIdentifier,
        animated: Bool,
        completionHandler: @escaping RoutingCompletionHandler) {
        if routeElementIdentifier == Routes.finished.value {
            navController.rootViewController.presentedViewController?.dismiss(animated: true, completion: nil)
            completionHandler()
        } else if routeElementIdentifier == Routes.trivia.value {
            navController.popViewController(true)
            completionHandler()
        } else {
            completionHandler()
        }
    }
}
