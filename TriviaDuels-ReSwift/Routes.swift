//
//  Routes.swift
//  Tribune
//
//  Created by Marcus Hays on 4/29/17.
//  Copyright © 2017 Punchkick Interactive. All rights reserved.
//

import Foundation
import ReSwiftRouter

//Protocol for being able to pull ids off of any routed controller
protocol RoutableIdentifiable {
    var routeIdentifier: RouteElementIdentifier { get }
    static var routeIdentifier: RouteElementIdentifier { get }
}

extension RoutableIdentifiable {
    //Don't change this. This must be static, otherwise the reflection will also use the memory address as part of the identifier, which we don't want.
    var routeIdentifier: RouteElementIdentifier {
        return type(of: self).routeIdentifier
    }

    static var routeIdentifier: RouteElementIdentifier {
        return String(reflecting: self)
    }
}

extension UIViewController: RoutableIdentifiable {}

enum Routes {
    case trivia
    case finished

    var value: RouteElementIdentifier {
        switch self {
            case .trivia: return TriviaController.routeIdentifier
            case .finished: return UIAlertController.routeIdentifier
        }
    }
}
