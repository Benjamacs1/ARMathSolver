//
//  SceneDelegate.swift
//  MathSolverAR
//
//  Created by Benjamin  on 2024-09-27.
//


import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene, 
        willConnectTo session: UISceneSession, 
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(
                rootView: contentView
            )
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    // Other scene delegate methods can remain default or be customized as needed.
}
