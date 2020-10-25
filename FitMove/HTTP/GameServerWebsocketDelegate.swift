//
//  GameServerWebsocketDelegate.swift
//  FitMove
//
//  Created by Peter Andrew on 11/10/20.
//

import Foundation

protocol GameServerWebsocketDelegate {
    var id:UUID { get }
    func didReceiveMessage(_ message:String)
    func onDisconnect()
}
