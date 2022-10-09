//
//  TabbarVC.swift
//  InstaClone
//
//  Created by mehmet duran on 7.10.2022.
//

import UIKit

enum TabbarItem:Int {
    case Feed
    case Upload
    case Settings
    
    var title:String {
        switch self {
        case .Feed: return "Feed"
        case .Upload: return "Upload"
        case .Settings: return "Settings"
        }
    }
    
    var icon:UIImage {
        switch self {
        case .Feed: return UIImage(systemName: "house.circle") ?? .add
        case .Upload: return .add
        case .Settings: return UIImage(systemName: "gearshape") ?? .add
        }
    }
    
    var viewController:UIViewController {
        switch self {
        case .Feed: return HomeVC()
        case .Upload: return UploadVC()
        case .Settings: return SettingsVC()
        }
    }
}

final class TabbarController:UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabbar()
    }
    
    private func configureTabbar() {
        
        let homeVC = UINavigationController(rootViewController: TabbarItem.Feed.viewController)
        let uploadVC = UINavigationController(rootViewController: TabbarItem.Upload.viewController)
        let settingsVC = UINavigationController(rootViewController: TabbarItem.Settings.viewController)
        
        homeVC.tabBarItem = UITabBarItem(title: TabbarItem.Feed.title, image: TabbarItem.Feed.icon, tag: TabbarItem.Feed.rawValue)
        uploadVC.tabBarItem = UITabBarItem(title: TabbarItem.Upload.title, image: TabbarItem.Upload.icon, tag: TabbarItem.Upload.rawValue)
        settingsVC.tabBarItem = UITabBarItem(title: TabbarItem.Settings.title, image: TabbarItem.Settings.icon, tag: TabbarItem.Settings.rawValue)
        
        viewControllers = [homeVC,uploadVC,settingsVC]
    }
    
}
