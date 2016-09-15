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
    
    class func makeRequest(currency: String, completionHandler: (NSDictionary?, NSError?) -> Void) -> String? {
        
//        var rate: String?
        
        Alamofire.request(.GET, "http://api.fixer.io/latest",parameters: ["base": "USD", "symbols":currency]).responseJSON { response in
            
            switch response.result {
            case .Success(let value):
                
                completionHandler(value as? NSDictionary, nil)
                
            case .Failure(let error):
                
                completionHandler(nil, error)
                
            }
            
//            print(response.result.value!)
//            let json = JSON(response.result.value!)
//            let rates = json["rates"]
//            rate = rates["GBP"].stringValue
        }
        
        return rate
    }
    
    class func convertCurrency(rate: Int, money: Int) -> Int {
        
    }
}