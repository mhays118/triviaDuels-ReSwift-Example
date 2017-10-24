//
//  AppDelegate.swift
//  TriviaDuels-ReSwift
//
//  Created by Marcus Hays on 6/7/17.
//  Copyright © 2017 PKI. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftRouter

let store = Store<AppState>(reducer: appReducer,
                            state: nil)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var router: Router<AppState>!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        UINavigationBar.appearance().isTranslucent = false

        let home = HomeController()
        let nav = NavigationController(rootViewController: home)

        router = Router<AppState>(store: store,
                                  rootRoutable: MainViewRoutable(nav),
                                  stateTransform: {
                                    $0.select {
                                        $0.navigationState
                                    }
        })

        window?.rootViewController = nav

        window?.makeKeyAndVisible()
        
        return true
    }
}
