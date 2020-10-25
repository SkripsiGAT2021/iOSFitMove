//
//  ApiEndpoint.swift
//  FitMove
//
//  Created by Peter Andrew on 14/10/20.
//

import Foundation

class APIEndpoint {
    static private let url = "skripsi2021.herokuapp.com"
//    static private let url = "192.168.100.5:8000"
    static private let base = "https://\(url)/"
    static let wsbase = "wss://\(url)/"
    static let signup = APIEndpoint.base + "auth/signup"
}
