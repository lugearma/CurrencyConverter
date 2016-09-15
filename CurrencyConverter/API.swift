//
//  API.swift
//  CurrencyConverter
//
//  Created by Luis Arias on 15/09/16.
//  Copyright © 2016 Luis Arias. All rights reserved.
//

import Alamofire
import Foundation

class API: NSObject {
    
    class func makeRequest(currency: String){
        Alamofire.request(.GET, "http://api.fixer.io/latest",parameters: ["base": "USD", "symbols":"MXN"]).responseJSON {
            response in
            print(response.result.value!)
        }
    }

}