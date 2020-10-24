//
//  GameServerWebsocketDelegate.swift
//  FitMove
//
//  Created by Peter Andrew on 11/10/20.
//

import Foundation

protocol GameServerWebsocketDelegate {
    func didReceiveMessage(_ message:String)
    func onDisconnect()
}
