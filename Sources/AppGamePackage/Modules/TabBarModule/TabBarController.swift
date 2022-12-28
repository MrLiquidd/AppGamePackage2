//
//  TabBarController.swift
//  AnimeApp
//
//  Created by Олег Борисов on 22.11.2022.
//

import UIKit

protocol TabBarViewProtocol: AnyObject{
    func setupView()
}

final public class TabBarController: UITabBarController{

    private lazy var homeVC: UIViewController = {
        let navController = UINavigationController()
        let homeVC  = HomeModuleBuilder.build()
        navController.viewControllers = [homeVC]
        navController.tabBarItem.title = "Home"
        navController.tabBarItem.image = UIImage(systemName: "house")
        navController.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        return navController
    }()

    private lazy var favoriteVC: UIViewController = {
        let navController = UINavigationController()
        let homeVC  = FavoriteModuleBuilder.build()
        navController.viewControllers = [homeVC]
        navController.tabBarItem.title = "Favorite"
        navController.tabBarItem.image = UIImage(systemName: "heart")
        navController.tabBarItem.selectedImage = UIImage(systemName: "heart.fill")
        return navController
    }()
    private lazy var profileVC: UIViewController = {
        let navController = UINavigationController()
        let homeVC  = ProfileModuleBuilder.build()
        navController.viewControllers = [homeVC]
        navController.tabBarItem.title = "Settings"
        navController.tabBarItem.image = UIImage(systemName: "gearshape")
        navController.tabBarItem.selectedImage = UIImage(systemName: "gearshape.fill")
        return navController
    }()


    var presenter: TabBarPresenterProtocol?{
        didSet{
            presenter?.notifyViewLoaded()
        }
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .systemOrange
    }

}

extension TabBarController: TabBarViewProtocol{
    public func setupView() {
        viewControllers = [
            homeVC,
            favoriteVC,
            profileVC
        ]
    }
}
