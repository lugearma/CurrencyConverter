//
//  Routes.swift
//  CurrencyConverter
//
//  Created by Luis Arias on 19/09/16.
//  Copyright © 2016 Luis Arias. All rights reserved.
//

import Foundation

enum Routes {
    case Latest
}

protocol Path {
    var path: String { get }
}

extension Routes: Path {
    var path: String {
        switch self {
        case .Latest:
            return "/latest"
        }
    }
}

protocol URL_Fixer: Path {
    var baseURL : String { get }
}

extension Routes: URL_Fixer {
    var baseURL: String {
        return "http://api.fixer.io"
    }
    
    func url(route: Routes) -> String {
        return route.baseURL.stringByAppendingString(route.path)
    }

}

