//
//  ContainerController.swift
//  Breathe
//
//  Created by Kiah Hewitt on 18/06/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class ContainerController: UIViewController {
    
    // MARK: - Properties
    
    var menuController: UIViewController!
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHomeController()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Handlers
    
    func configureHomeController() {
        let homeController = HomeController()
        homeController.delegate = self
        let controller = UINavigationController(rootViewController: homeController)
        
        view.addSubview(controller.view)
        addChild(controller)
        controller.didMove(toParent: self)
    }
    
    func configureMenuController() {
        if menuController == nil {
//            add our menu controller
            menuController = MenuController()
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
            print("Did add menu controller")
        }
    }
    
}

extension ContainerController: HomeControllerDelegate {
    func handleMenuToggle() {
        configureMenuController()
    }
}
