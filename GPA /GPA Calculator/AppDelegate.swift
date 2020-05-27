//
//  AppDelegate.swift
//  GPA Calculator
//
//  Created by Ryan on 2020/5/22.
//  Copyright © 2020 Ryan. All rights reserved.
//
import UIKit
import ESTabBarController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        getData()
        window = UIWindow.init()
        let navigationController = UINavigationController(rootViewController: HomeViewController())
        window?.rootViewController = navigationController
        //window?.rootViewController = customTabBarViewController()
        window?.makeKeyAndVisible()
        
        UISearchBar.appearance().tintColor = .myPurple
        UINavigationBar.appearance().tintColor = .myPurple
        
        return true
    }

    
    
}


/// 自定义Tab视图控制器
/// - Returns: ESTabBarController 返回视图控制器
func customTabBarViewController() -> ESTabBarController {
    let homeViewController = HomeViewController()
    let mineViewController = MineViewController()
    
    let homeNavigationController = UINavigationController(rootViewController: homeViewController)
    let mineNavigationController = UINavigationController(rootViewController: mineViewController)
    
    homeViewController.tabBarItem = ESTabBarItem.init(ExampleBouncesContentView(), title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"))
    mineViewController.tabBarItem = ESTabBarItem.init(ExampleBouncesContentView(), title: "me", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"))
    
    let tabBarController = ESTabBarController()
    
    
    tabBarController.viewControllers = [homeNavigationController ,mineNavigationController]
    tabBarController.tabBar.backgroundColor = .white
    tabBarController.tabBar.backgroundImage = UIImage(named: "background")
    return tabBarController
}
