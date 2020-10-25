//
//  GamePlayMirror+GamePlayMechanic.swift
//  FitMove
//
//  Created by Peter Andrew on 25/10/20.
//

import Foundation
import MLKit

extension GamePlayMirror: GameServerWebsocketDelegate {
    
    func didReceiveMessage(_ message: String) {
        // Do do somthing when message come in
        
        // if message == startgame
        //      true: initTimer()
       
    }
    
    func onDisconnect() {
        // Do something when disconnected
    }
    
    
}
