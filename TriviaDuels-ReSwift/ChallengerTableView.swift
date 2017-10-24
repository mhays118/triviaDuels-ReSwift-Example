//
//  ChallengerTableView.swift
//  TriviaDuels-ReSwift
//
//  Created by Marcus Hays on 6/7/17.
//  Copyright © 2017 PKI. All rights reserved.
//

import Foundation
import UIKit
import ReSwiftRouter

class ChallengerTableView: UIView {
    let challengerIdentifier = "ChallengerCellIdentifier"

    fileprivate(set) lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self,
                           forCellReuseIdentifier: self.challengerIdentifier)
        table.rowHeight = UITableViewAutomaticDimension
        table.estimatedRowHeight = 75.0
        table.separatorStyle = .none
        table.delegate = self
        table.dataSource = self
        return table
    }()

    var items: [Player] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    fileprivate func setup() {
        self.backgroundColor = .white
        self.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
    }
}

extension ChallengerTableView : UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        store.dispatch(ChallengePlayer(player: items[indexPath.row]))
        let previous = store.state.navigationState.route
        store.dispatch(SetRouteAction(previous + [Routes.trivia.value]))
    }
}

//MARK: TableViewDelegate and DataSource
extension ChallengerTableView : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.challengerIdentifier)!
        cell.textLabel?.text = items[indexPath.row].username
        return cell
    }
}
