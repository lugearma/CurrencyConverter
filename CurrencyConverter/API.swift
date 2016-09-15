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
    
    class func makeRequest(){
        Alamofire.request(.GET, "http://api.fixer.io/latest?base=USD&symbols=MXN").response { response in
            
            print(response.1)  // original URL request
            
        }
    }

}