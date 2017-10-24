//
//  HomeController.swift
//  TriviaDuels-ReSwift
//
//  Created by Marcus Hays on 6/7/17.
//  Copyright © 2017 PKI. All rights reserved.
//

import Foundation
import UIKit
import ReSwift

class HomeController: UIViewController {

    fileprivate let challengerTable = ChallengerTableView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()

        store.dispatch(fetchChallengers)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        store.subscribe(self) {
            $0.select {
                $0.challengers
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
    }

    fileprivate func setup() {
        self.view.add(child: challengerTable, matchBounds: true)
    }
}

extension HomeController: StoreSubscriber {
    func newState(state: [Player]) {
        challengerTable.items = state
    }
}
