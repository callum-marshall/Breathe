//
//  SettingsController.swift
//  Breathe
//
//  Created by Kiah Hewitt on 18/06/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Mapbox
import UIKit

class SettingsController: UIViewController {
    //    MARK: - Properties
    
    var borough: String?
    
    //    MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        
//        let mapView = MGLMapView(frame: view.bounds)
//     
////        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
////        mapView.delegate = HomeController
////
////        mapView.styleURL = MGLStyle.streetsStyleURL
////
////        // coordinates for London, UK
////        //                var center = CLLocationCoordinate2D(latitude: 51.509865, longitude: -0.118092)
////        let center = CLLocationCoordinate2D(latitude: 51.509865, longitude: -0.118092)
////
////
////        // set starting point
//        mapView.setCenter(center, zoomLevel: 6, direction: 0, animated: false)
////
//        view.addSubview(mapView)
        
        // MARK: - Example of Passing in Data
        
        if let borough = borough {
            print("\(borough) has PM10: 5")
        } else {
            print("Borough not found")
        }
        
    }
    
    //    MARK: - Selectors
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    //    MARK: - Helper Functions
    
//    func configureTableView() {
//        tableview = UITableview()
//        tableview.delegate = self
//        tableview.dataSource = self
//        table.rowHeight = 60
//
//        tableView.register(SettingsCell.self, for)
//
//        tableView.register(SettingsCell.self)
//    }
    
    func configureUI() {
//        configureTableView()
        
        view.backgroundColor = .white
        
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Settings"
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "hamburger-1").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleDismiss))
    }
    
}
