//
//  SceneDelegate.swift
//  ClassAndStruct
//
//  Created by ihan carlos on 11/12/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let vc: ViewController = ViewController()
        let navVC = UINavigationController(rootViewController: vc)
        window.rootViewController = navVC
        window.makeKeyAndVisible()
        self.window = window
    }
}
