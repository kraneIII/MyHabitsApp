//
//  SceneDelegate.swift
//  MyHabits
//
//  Created by Ковалев Никита on 08.01.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene)
        
        let habitsViewControlelr = HabitsViewController()
        let infoViewController = InfoViewController()
        
        habitsViewControlelr.tabBarItem = UITabBarItem(title: "Habits", image: UIImage(systemName: "square.split.1x2.fill"), tag: 0)
        
        infoViewController.tabBarItem = UITabBarItem(title: "Info", image: UIImage(systemName: "info.circle.fill"), tag: 1)
        
        let controllers = [habitsViewControlelr, infoViewController]
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor =  UIColor.myColor(dark: #colorLiteral(red: 0.1098039076, green: 0.1098039076, blue: 0.1098039076, alpha: 1), any: .white)
        tabBarController.tabBar.tintColor = UIColor.myColor(dark: .orange, any:#colorLiteral(red: 0.1568627059, green: 0.1568627059, blue: 0.1568627059, alpha: 1) )
        tabBarController.viewControllers = controllers.map {
            UINavigationController(rootViewController: $0)
        }
    
        window.rootViewController = tabBarController
        
        window.makeKeyAndVisible()
        
        self.window = window
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        UNUserNotificationCenter.current().setBadgeCount(0)
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

