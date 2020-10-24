//
//  LocalDB.swift
//  FitMove
//
//  Created by Peter Andrew on 15/10/20.
//

import Foundation

class LocalDB {
    static let TOKEN_KEY = "userID"
    static private let defaults = UserDefaults.standard
    
    static func getTokenID()->String? {
        return LocalDB.defaults.string(forKey: LocalDB.TOKEN_KEY)
    }
    
    static func setTokenID(id:String) {
        LocalDB.defaults.setValue(id, forKey: LocalDB.TOKEN_KEY)
    }
}
