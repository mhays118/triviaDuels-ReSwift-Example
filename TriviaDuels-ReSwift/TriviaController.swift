//
//  TriviaController.swift
//  TriviaDuels-ReSwift
//
//  Created by Marcus Hays on 6/9/17.
//  Copyright © 2017 PKI. All rights reserved.
//

import Foundation

import UIKit
import ReSwift
import ReSwiftRouter

class TriviaController: UIViewController {

    fileprivate lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()

    fileprivate lazy var answerView = {
        return TriviaAnswerOptionsView(frame: .zero)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        store.dispatch(fetchQuestions)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        store.subscribe(self) {
            $0.select {
                $0.duel?.challengerTriva
                }.skipRepeats { $0.0 == $0.1 }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
    }

    fileprivate func setup() {
        self.view.backgroundColor = .white

        let stack = UIStackView(arrangedSubviews: [questionLabel, answerView])
        stack.axis = .vertical
        stack.distribution = .equalCentering
        stack.alignment = .center
        stack.spacing = 16

        self.view.add(child: stack, matchBounds: true)

        self.view.layoutIfNeeded()
    }
}

extension TriviaController: StoreSubscriber {
    func newState(state: TriviaState?) {
        guard let state = state else { return }
        guard let index = state.currentQuestionIndex else { return }
        let current = state.questions[index]
        questionLabel.text = current.prompt
        answerView.options = current.options

        if state.isFinished {
            let previousRoute = store.state.navigationState.route
            store.dispatch(SetRouteAction(previousRoute + [Routes.finished.value]))
        }
        
    }
}
