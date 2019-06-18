//
//  ModelOption.swift
//  Breathe
//
//  Created by Student on 18/06/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

enum MenuOption: Int, CustomStringConvertible {
    
    case Profile
    case Inbox
    case Notifications
    case Settings
    
    var description: String {
        switch self {
        case .Profile: return "Profile"
        case .Inbox: return "Inbox"
        case .Notifications: return "Notifications"
        case .Settings: return "Settings"
        }
    }
    var image: UIImage {
        switch self {
        case .Profile: return UIImage(named: "hamburger-1") ?? UIImage()
        case .Inbox: return UIImage(named: "hamburger-1") ?? UIImage()
        case .Notifications: return UIImage(named: "hamburger-1") ?? UIImage()
        case .Settings: return UIImage(named: "hamburger-1") ?? UIImage()
        }
    }
}
