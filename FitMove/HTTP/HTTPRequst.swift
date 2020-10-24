//
//  HTTPRequst.swift
//  FitMove
//
//  Created by Peter Andrew on 14/10/20.
//

import Foundation

class HTTPRequest {
    private static let session = URLSession.shared
    static func post(urlString:String, json:[String:String], completion: @escaping (_ data:Data?,_ response:URLResponse?,_ error:Error?)->()) {
        var request = getURLRequestByURLString(urlString: urlString)
        request.httpMethod = "POST"
        request.setValue("Mobile-Apps-FitMove", forHTTPHeaderField: "X-Device-From")
        request.setValue("SkripsiGAT2021", forHTTPHeaderField: "Authorization")
//        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        let postString = "name=\(String(describing: json["name"]!))&email=\(json["email"]!)"
        request.httpBody = postString.data(using: String.Encoding.utf8);
        let task = session.dataTask(with: request) { data, response, error in
            completion(data,response, error)
        }
        task.resume()
    }
    
    private static func getURLRequestByURLString(urlString:String)->URLRequest {
        return URLRequest(url: URL(string: urlString)!)
    }
}
