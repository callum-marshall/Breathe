//
//   NetworkingClient.swift
//  Breathe
//
//  Created by Student on 12/06/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation
import Alamofire

class NetworkingClient {
    
    func execute(_ url: URL) {
        Alamofire.request(url).validate().responseJSON { response in
            if let error = response.error {
                
            } else if let jsonArray = response.result.value as? [[String: Any]] {
                
            } else if
        }
    }
    
}
