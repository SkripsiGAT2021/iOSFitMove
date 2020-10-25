//
//  GameLogic+GameWebSocketDelegate.swift
//  FitMove
//
//  Created by Peter Andrew on 24/10/20.
//

import Foundation

extension GameLogic: GameServerWebsocketDelegate {
    func didReceiveMessage(_ message: String) {
        if message == "START" {
            gameState = .started
        }
    }
    
    func onDisconnect() {
        print("GAME STOPPED")
    }
}
