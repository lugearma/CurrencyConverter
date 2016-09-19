//
//  API.swift
//  CurrencyConverter
//
//  Created by Luis Arias on 15/09/16.
//  Copyright © 2016 Luis Arias. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON

class API: NSObject {
    
    class func getCurrencyValue(currency: String, completionHandler: (NSDictionary?, NSError?) -> Void) {
        
        Alamofire.request(.GET, "http://api.fixer.io/latest",parameters: ["base": "USD", "symbols":currency]).validate().responseJSON { response in
            
            switch response.result {
            case .Success(let value):
                completionHandler(value as? NSDictionary, nil)
            case .Failure(let error):
                completionHandler(nil, error)
            }
        }
    }
}