//
//  NavigationController.swift
//  Tribune
//
//  Created by Marcus Hays on 4/30/17.
//  Copyright © 2017 Punchkick Interactive. All rights reserved.
//

import Foundation
import UIKit
import ReSwift
import ReSwiftRouter

/*
 When using ReSwiftRouter we want every view controller change to be reflected by a route update. This means we need to be notified when UIKit's container view controllers trigger VCs to be presented or hidden.
 
 credit to rpassis in https://github.com/ReSwift/ReSwift-Router/issues/17#issuecomment-233152205
 and to: http://irace.me/navigation-coordinators
 */

final class NavigationController: UIViewController {
    // MARK: - Inputs

    let rootViewController: UIViewController

    // MARK: - Lazy views

    private lazy var childNavigationController: UINavigationController =
        UINavigationController(rootViewController: self.rootViewController)

    // MARK: - Initialization

    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController

        super.init(nibName: nil, bundle: nil)
    }

    //NOTES: This has not tested this with storyboards
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        childNavigationController.delegate = self

        addChildViewController(childNavigationController)
        view.addSubview(childNavigationController.view)
        childNavigationController.didMove(toParentViewController: self)

        childNavigationController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            childNavigationController.view.topAnchor.constraint(equalTo: view.topAnchor),
            childNavigationController.view.leftAnchor.constraint(equalTo:view.leftAnchor),
            childNavigationController.view.rightAnchor.constraint(equalTo:view.rightAnchor),
            childNavigationController.view.bottomAnchor.constraint(equalTo:view.bottomAnchor)
            ])
    }

    // MARK: - Exposed UINavigationController methods

    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        childNavigationController.pushViewController(viewController, animated: animated)
    }

    func popViewController(_ animated: Bool) {
        childNavigationController.popViewController(animated: animated)
    }
}

// MARK: - UINavigationControllerDelegate

extension NavigationController: UINavigationControllerDelegate {
    // This is how we keep the Route stack up to date when a back button is pressed, or the user swipes.

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // The source view controller was popped, let's check if the state needs updating
        var newRoute = store.state.navigationState.route
        //If we only have one item in our route, we don't want to pop it
        guard newRoute.count > 0 else { return }
        newRoute = newRoute.filter { route in
            let navRouteIds = navigationController.childViewControllers.flatMap { $0 as? RoutableIdentifiable }
            return navRouteIds.contains { $0.routeIdentifier == route }
        }
        if store.state.navigationState.route.count != newRoute.count {
            store.dispatch(ReSwiftRouter.SetRouteAction(newRoute))
        }
    }
}

