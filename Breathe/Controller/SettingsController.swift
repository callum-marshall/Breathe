//
//  SettingsController.swift
//  Breathe
//
//  Created by Kiah Hewitt on 18/06/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {
    //    MARK: - Properties
    
    //    MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //    MARK: - Selectors
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    //    MARK: - Helper Functions
    
    func configureUI() {
        view.backgroundColor = .white
        
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Settings"
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "hamburger-1").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleDismiss))
    }
    
}
