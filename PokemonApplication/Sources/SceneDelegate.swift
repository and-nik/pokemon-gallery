//
//  SceneDelegate.swift
//  Pokemon Application
//
//  Created by And Nik on 24.01.23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene  = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let tabBarController = TabBarController()
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

}

