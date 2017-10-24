//
//  TriviaAnswersView.swift
//  TriviaDuels-ReSwift
//
//  Created by Marcus Hays on 6/11/17.
//  Copyright © 2017 PKI. All rights reserved.
//

import Foundation
import UIKit

class TriviaAnswerOptionsView: UIView {

    fileprivate(set) lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 16
        return stack
    }()

    var options: [String] = [] {
        didSet {
            let createLabel = { (index: Int, option: String) -> UIButton in
                let button = UIButton()
                button.setTitle(option, for: .normal)
                button.setTitleColor(.white, for: .normal)
                button.backgroundColor = .blue
                button.tag = index
                button.addTarget(self, action: #selector(self.selectedOption(sender:)), for: .touchUpInside)
                return button
            }
            stack.arrangedSubviews.forEach { $0.removeFromSuperview() }
            options.enumerated().map(createLabel).forEach { stack.addArrangedSubview($0) }
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

    func selectedOption(sender: UIButton) {
        store.dispatch(AnswerQuestion(answer: sender.tag))
    }

    fileprivate func setup() {
        self.backgroundColor = .white
        self.addSubview(stack)
        self.add(child: stack, matchBounds: true)
    }
}
